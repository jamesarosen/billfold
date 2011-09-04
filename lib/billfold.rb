module Billfold

  class <<self
    # ## Billfold.user_class
    #
    # Used by `Billfold::Identity.update_or_create!` when building new users
    # and by `Billfold::ActiveRecordIdentity` for the `belongs_to :user`
    # association. By default, `::User` if that exists.
    def user_class
      @user_class ||= (Object.const_defined?(:User) ? User : nil)
    end

    attr_writer :user_class

    # ## Billfold.identity_class
    #
    # Used by `Billfold::AuthenticationController.update_or_create` By
    # default, `::Identity` if that exists.
    def identity_class
      @user_class ||= (Object.const_defined?(:Identity) ? Identity : nil)
    end

    attr_writer :identity_class
  end

  require 'billfold/identity'
  require 'engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end
