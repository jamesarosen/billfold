module Billfold

  # ## Billfold::User
  #
  # ### Attributes
  #  * `name` -- something to display; required
  class User < ActiveRecord::Base

    set_table_name 'users'

    validates_presence_of :name

    # Merge this user into another user, deleting this user and moving its
    # identities to the other.
    def merge_into!(other)
      raise ArgumentError.new("#{other} is not a User") unless other.kind_of?(::Billfold::User)
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
