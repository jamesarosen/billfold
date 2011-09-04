require 'billfold'

module Billfold

  # ## Billfold::User
  #
  # Support for a user class. If you are using ActiveRecord, you
  # probably want `Billfold::ActiveRecordUser`, which includes everything
  # in this module.
  #
  # `Billfold::Identity` requires that user instances have a `name` attribute.
  #
  # `Billfold::ControllerSupport` requires that the user class respond to
  # `:find_by_id`.
  module User

    # Merge this user into another user, deleting this user and moving its
    # identities to the other.
    def merge_into!(other)
      raise NotImplementedError.new("Classes including Billfold::User MUST redefine instance method merge_into!")
    end

  end

end
