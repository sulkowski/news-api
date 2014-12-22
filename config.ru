require 'rack'
require_relative 'lib/api/v1/news'

Rack::Handler::WEBrick.run Api::V1::News.new
