require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)

require 'dotenv'
Dotenv.load

require 'active_record'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

require 'app/models'
require 'app/routes'
require 'app/helpers'

module News
  class App < Sinatra::Application
    configure do
      database_url = ENV['DATABASE_URL'] || "postgresql://localhost/news_#{environment}"
      ::ActiveRecord::Base.establish_connection(database_url)
      ::ActiveRecord::ConnectionAdapters::ConnectionManagement
    end

    configure :development do
      ::ActiveRecord::Base.logger = Logger.new(STDOUT)
    end

    use Routes::Stories
    use Routes::Users
  end
end

include News::Models
