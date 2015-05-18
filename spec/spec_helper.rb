ENV['RACK_ENV'] ||= 'test'

require 'bcrypt'
require 'database_cleaner'
require 'rack/test'
require 'rspec/json_expectations'
require './app'

Dir[
  'spec/helpers/**/*.rb',
  'spec/support/**/*.rb'
].each { |f| require f }

BCrypt::Engine.cost = BCrypt::Engine::MIN_COST

def app
  Rack::Lint.new(News::App.new)
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include ApplicationHelper
  config.color = true

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with :deletion
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
