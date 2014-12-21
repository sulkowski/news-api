require 'rack'
require_relative 'lib/app'

Rack::Handler::WEBrick.run App.new
