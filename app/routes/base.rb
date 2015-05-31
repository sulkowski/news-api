module News
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, App.root
        set :show_exceptions, :after_handler
      end

      helpers Helpers::ResponseHeaders
      helpers Helpers::Authentication

      respond_to :json, :xml

      use Rack::Parser, parsers: {
        'application/json' => proc { |body| ::MultiJson.decode body }
      }

      error News::Exceptions::AuthenticationError do
        status 401
        respond_with error: { code: 401, message: 'Not authenticated' }
      end

      error News::Exceptions::AuthorizationError do
        status 403
        respond_with error: { code: 403, message: 'Not authorized' }
      end

      error ActiveRecord::RecordNotFound do |error|
        status 404
        respond_with error: { code: 404, message: error.to_s }
      end

      error ActiveRecord::RecordInvalid do |error|
        status 422
        respond_with error: { code: 422, message: error.to_s, errors: error.record.errors }
      end
    end
  end
end
