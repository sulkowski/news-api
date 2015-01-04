module News
  module V1
    module Routes
      class Base < Sinatra::Base
        helpers Sinatra::JSON

        register Sinatra::Namespace
        register Sinatra::Reloader

        set :show_exceptions, false

        error ActiveRecord::RecordNotFound do
          status 404
          json error: 'Record not found.'
        end
      end
    end
  end
end
