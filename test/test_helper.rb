# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'factory_girl'
require 'forgery'
require 'jbuilder'

Rails.backtrace_cleaner.remove_silencers!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

DUMMY_APP = Rack::Builder.parse_file('test/dummy/config.ru').first

FactoryGirl.find_definitions

Turn.config.format = :pretty
Turn.config.natural = true

