require 'billfold'
require 'rails'
require 'action_controller'
require 'application_helper'

module Billfold
  class Engine < Rails::Engine

    # Config defaults
    config.mount_at = '/'

    # Load rake tasks
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'rails/railties/tasks.rake')
    end

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
