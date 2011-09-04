require 'active_support/concern'
require 'billfold/identity'

module Billfold

  # ## Billfold::ActiveRecordIdentity
  #
  # Support for an ActiveRecord Identity class. (Builds on top of
  # `Billfold::Identity`)
  module ActiveRecordIdentity

    extend ActiveSupport::Concern

    included do
      raise "Cannot define identity class until Billfold.user_class is set" unless Billfold.user_class.present?
      belongs_to :user, :class_name => Billfold.user_class.to_s
      serialize  :data
      validates_presence_of :user, :provider, :value

      # There can only be one identity with a given type and value
      validates_uniqueness_of :value, :scope => [ :type ]
    end

    module ClassMethods

      include Billfold::Identity::ClassMethods

      # ### Billfold::Identity.with_provider_and_value
      #
      # Return the identity with the given `provider` and `value`, or `nil`,
      # if no such identity exists. Including classes *must* redefine this
      # method.
      def with_provider_and_value(provider, value)
        where(:provider => provider, :value => value).first
      end

    end

    module InstanceMethods

      include Billfold::Identity::InstanceMethods

    end

  end

end
