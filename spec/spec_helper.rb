require 'database_cleaner'
require 'rack/test'

ENV['RACK_ENV'] ||= 'test'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:deletion)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
