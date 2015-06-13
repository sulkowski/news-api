module News
  module Routes
    class Base < Sinatra::Application
      helpers Helpers::ResponseHeaders
      helpers Helpers::Authentication
      helpers Helpers::ApiVersioning

      API_TYPES_MAPPING = [
        { mime_type: 'application/json', versions: [1, 2] },
        { mime_type: 'application/xml',  versions: [1, 2] }
      ]

      before do
        modify_api_accept_headers(mappings: API_TYPES_MAPPING, vendor: 'news-app')
      end

      respond_to :json, :xml

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
