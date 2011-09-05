require 'active_support/concern'
require 'billfold/user'

module Billfold

  # ## Billfold::ActiveRecordUser
  #
  # Support for an ActiveRecord User class. (Builds on top of
  # `Billfold::User`)
  module ActiveRecordUser

    extend ActiveSupport::Concern

    included do
      validates_presence_of :name
      has_many :identities
    end

    module InstanceMethods

      # Merge this user into another user, deleting this user and moving its
      # identities to the other.
      def merge_into!(other)
        raise ArgumentError.new("#{other} is not a #{Billfold.user_class}") unless other.kind_of?(Billfold.user_class)
        raise ArgumentError.new("#{other} is not saved") if other.new_record?
        transaction do
          identities.update_all({ :user_id => other.id })
          perform_additional_merge_operations!(other)
          destroy
        end
      end

      private

      # This method is called after all identities have been moved from
      # `other` to `self`, but before `other` has been destroyed and before the
      # end of the transaction. By default, it does nothing.
      def perform_additional_merge_operations!(other)
      end

    end

  end

end
