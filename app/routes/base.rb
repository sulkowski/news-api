module News
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, App.root
        set :show_exceptions, :after_handler
      end

      use Rack::Parser, parsers: {
        'application/json' => proc { |body| ::MultiJson.decode body }
      }

      helpers Helpers::ResponseHeaders
      helpers Helpers::Authentication

      error News::Models::User::NotAuthorized do
        halt 401, json(error: {code: 401, message: 'Not authorized'})
      end

      error ActiveRecord::RecordNotFound do |error|
        halt 404, json(error: {code: 404, message: error.to_s})
      end

      error ActiveRecord::RecordInvalid do |error|
        halt 422, json(error: {code: 422, message: error.to_s, errors: error.record.errors})
      end
    end
  end
end
