require 'sinatra/base'
require 'sinatra/json'

module Api
  module V1
    class News < Sinatra::Base
      helpers Sinatra::JSON

      # Stories
      get '/api/v1/stories' do
        json note: 'Requested: /api/v1/stories'
      end

      # post '/api/v1/stories' do; end

      get '/api/v1/stories/:id' do
        json note: "Requested: /api/v1/stories/#{params[:id]}"
      end

      # patch '/api/v1/stories/:id' do; end

      # Vote
      # post '/api/v1/stories/:id/vote/up' do; end
      # post '/api/v1/stories/:id/vote/down' do; end
      # delete '/api/v1/stories/:id/vote' do; end

      # Users
      # post '/api/v1/users' do; end
    end
  end
end
