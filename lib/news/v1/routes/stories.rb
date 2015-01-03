module News
  module V1
    module Routes
      class Stories < Sinatra::Base
        helpers Sinatra::JSON

        # Stories
        get '/v1/stories' do
          json note: 'Requested: /v1/stories'
        end
        # post '/api/v1/stories' do; end
        get '/v1/stories/:id' do
          json note: "Requested: /v1/stories/#{params[:id]}"
        end
        # patch '/v1/stories/:id' do; end

        # Voting
        # put '/v1/stories/:id/vote/up' do; end
        # put '/v1/stories/:id/vote/down' do; end
        # delete '/v1/stories/:id/vote' do; end
      end
    end
  end
end
