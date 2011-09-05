module Billfold

  autoload :ControllerSupport,    'billfold/controller_support'
  autoload :Identity,             'billfold/identity'
  autoload :User,                 'billfold/user'
  autoload :ActiveRecordIdentity, 'billfold/active_record_identity'
  autoload :ActiveRecordUser,     'billfold/active_record_user'

  class <<self
    # ## Billfold.user_class
    #
    # Used by `Billfold::Identity.update_or_create!` when building new users
    # and `Billfold::ControllerSupport` when looking up the current user
    # from the session. Calculated from `Billfold.user_class_name`.
    def user_class
      constantize user_class_name
    end

    # Used by `Billfold::ActiveRecordIdentity` for the `belongs_to :user`
    # association and by `Billfold.user_class` for getting the actual
    # class. By default, "User"
    def user_class_name
      @user_class ||= 'User'
    end

    attr_writer :user_class_name

    # ## Billfold.identity_class
    #
    # Used by `Billfold::IdentitiesController.update_or_create`. Calculated
    # from `Billfold.identity_class_name`.
    def identity_class
      constantize identity_class_name
    end

    def identity_class_name
      @identity_class ||= 'Identity'
    end

    attr_writer :identity_class_name

    private

    def constantize(string)
      return nil if string.blank?
      return string.constantize if string.respond_to?(:constantize)
      string.to_s.split('::').inject(Object) do |memo, name|
        raise "#{memo}::#{name} does not exist" unless memo.const_defined?(name)
        memo = memo.const_get(name)
      end
    end
  end

  require 'billfold/identity'
  require 'billfold/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
end
