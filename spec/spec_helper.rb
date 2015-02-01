ENV['RACK_ENV'] ||= 'test'

require 'database_cleaner'
require 'rack/test'
require './app'

def app
  Rack::Lint.new(News::App.new)
end

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with :deletion
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
