require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)

require 'dotenv'
Dotenv.load

require 'active_record'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/namespace'

require 'app/models'
require 'app/routes'
require 'app/helpers'
require 'app/exceptions'

require 'multi_json'

module News
  class App < Sinatra::Application
    configure do
      database_url = ENV.fetch('DATABASE_URL')
      ::ActiveRecord::Base.establish_connection(database_url)
      ::ActiveRecord::ConnectionAdapters::ConnectionManagement
    end

    configure :development do
      ::ActiveRecord::Base.logger = Logger.new(STDOUT)
    end

    use Routes::Legacy::Stories
    use Routes::Legacy::Users

    use Routes::V1::Stories
    use Routes::V1::Users

    use Routes::V2::Stories
    use Routes::V2::Users
  end
end

include News::Models
