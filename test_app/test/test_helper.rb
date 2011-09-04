ENV["RAILS_ENV"] = "test"
require 'bundler'
Bundler.setup

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/unit'
require 'mocha'
require 'factory_girl'

require File.expand_path('../prepare_database', __FILE__)
require 'billfold'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

MiniTest::Unit.autorun