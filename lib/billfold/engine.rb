require 'billfold'
require 'rails'

module Billfold
  class Engine < Rails::Engine
    engine_name :my_rails_engine

    # Config defaults
    config.mount_at = '/'

    # Check the gem config
    initializer "check config" do |app|
      # make sure mount_at ends with trailing slash
      config.mount_at += '/' unless config.mount_at.last == '/'
    end

    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    ActiveSupport.on_load(:action_controller) do
      include Billfold::ControllerSupport
    end
  end
end
