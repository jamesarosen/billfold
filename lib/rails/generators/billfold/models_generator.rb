require 'rails/generators'

module Billfold
  class ModelsGenerator < Rails::Generators::Base
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    def copy_models
      copy_file "user.rb",     "app/models/user.rb"
      copy_file "identity.rb", "app/models/identity.rb"
    end
  end
end
