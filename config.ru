require 'rack'
require_relative 'lib/news_api'

Rack::Handler::WEBrick.run NewsApi.new
