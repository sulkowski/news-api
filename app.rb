require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)

require 'dotenv'
Dotenv.load

require 'active_record'
require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/router'
require 'sinatra/namespace'

require 'app/models'
require 'app/routes'
require 'app/services'
require 'app/helpers'
require 'app/exceptions'

require 'multi_json'

module News
  class App < Sinatra::Base
    configure do
      database_url = ENV.fetch('DATABASE_URL')
      ::ActiveRecord::Base.establish_connection(database_url)
      ::ActiveRecord::ConnectionAdapters::ConnectionManagement
    end

    use Sinatra::Router do
      def version(version, &block)
        condition = lambda do |env|
          accept_headers = Sinatra::Request.new(env).accept
          api_accept_header = accept_headers.find do |header|
            Services::ApiHeaderMatcher[accept_header: header.to_s, vendor: 'news-app']
          end
          Services::ApiVersionExtracter[api_accept_header.to_s] == version
        end
        with_conditions(condition, &block)
      end

      version 2 do
        mount Routes::V2::Stories
        mount Routes::V2::Users
      end

      mount Routes::V1::Stories
      mount Routes::V1::Users
    end
  end
end

include News::Models
