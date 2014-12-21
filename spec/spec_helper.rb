require 'rack/test'
require 'news_api'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    Rack::Lint.new(NewsApi.new)
  end
end
