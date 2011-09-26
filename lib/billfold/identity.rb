require 'billfold'

module Billfold

  # ## Billfold::Identity
  #
  # Support for an identity class. If you are using ActiveRecord, you
  # probably want `Billfold::ActiveRecordIdentity`, which includes everything
  # in this module.
  #
  # Requires the following attributes
  #  * `user` -- the owning `Billfold::User` instance; required
  #  * `provider` -- the OmniAuth provider name (e.g. "twitter"); required
  #  * `value` -- the unique identifier (within the scope of `provider`) of
  #               the identity (e.g. "my_twitter_handle"); required
  #  * `data` -- additional information passed in from OmniAuth under the
  #              `"user_info"` key
  module Identity

    def self.included(base)
      base.extend ClassMethods
      base.send(:include, InstanceMethods)
    end

    module ClassMethods

      # ### Billfold::Identity.with_provider_and_value
      #
      # Return the identity with the given `provider` and `value`, or `nil`,
      # if no such identity exists. Including classes *must* redefine this
      # method.
      def with_provider_and_value(provider, value)
        raise NotImplementedError.new('classes including Billfold::Identity MUST redefine class method with_provider_and_value')
      end

      # ### Billfold::Identity.update_or_create!
      #
      # Updates or creates a `Billfold::Identity`.
      #
      # ### Parameters: a single `Hash` with the following keys:
      #  * `:provider` -- the name of an OmniAuth provider (e.g. "twitter")
      #  * `:user` -- if nil, creates a new `User` for the `Identity`
      #  * `:value` -- the unique identifier
      #  * `:data` -- extra data for the Identity
      #
      # ### Behavior
      #
      # If `:provider` or `:value` is `nil`, this method raises an
      # `ArgumentError`.
      #
      # If `:user` is `nil`, this method creates a new `User` for the `Identity`.
      #
      # If `:user` exists and there is no other `Identity` with the
      # same `:value`, this method adds a new `Identity` to the `User`.
      #
      # If there exists another `Identity` with the same `:value` and
      # that `Identity` is owned by the given `User`, this method updates that
      # `Identity`.
      #
      # If `:user` exists and there exists another `Identity` with
      # the same `:value` and that `Identity` is owned by a *different* `User`,
      # this method merges that User into `:user` and updates the `Identity`.
      def update_or_create!(attributes = {})
        raise ArgumentError.new("provider must not be blank") if attributes[:provider].blank?
        raise ArgumentError.new("value must not be blank") if attributes[:value].blank?
        identity = with_provider_and_value(attributes[:provider], attributes[:value])
        if identity
          old_owner, new_owner = identity.user, attributes[:user]
          attributes.delete(:user) if attributes[:user].nil?
          transaction do
            identity.update_attributes!(attributes)
            old_owner.merge_into!(new_owner) if new_owner && old_owner != new_owner
          end
        else
          identity = new(attributes)
          identity.user = attributes[:user] || ::Billfold.user_class.new(:name => identity.name_for_user)
          identity.save!
        end
        identity
      end

    end

    module InstanceMethods

      # ### Billfold::Identity#name_for_user
      #
      # When creating a new user from an identity, this method is used to
      # generate a display name. By default, it tries to get the user's name
      # from the OmniAuth data and falls back on using the identity's provider
      # and value, but subclasses may have something better to do.
      def name_for_user
        (data && data['name']) || "#{provider} #{value}"
      end

    end

  end

end
