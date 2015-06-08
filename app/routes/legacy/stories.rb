module News
  module Routes
    module Legacy
      class Stories < Base
        namespace '/stories' do
          get do
            redirect '/v1/stories', 301
          end

          get '/:id' do
            redirect "/v1/stories/#{params['id']}", 301
          end

          patch '/:id' do
            redirect "/v1/stories/#{params['id']}", 301
          end

          post do
            redirect '/v1/stories', 301
          end

          get '/:id/url' do
            redirect "/v1/stories/#{params['id']}/url", 301
          end

          # Voting
          namespace '/:id/vote' do
            put '/up' do
              redirect "/v1/stories/#{params['id']}/vote/up", 301
            end

            put '/down' do
              redirect "/v1/stories/#{params['id']}/vote/down", 301
            end

            delete do
              redirect "/v1/stories/#{params['id']}/vote", 301
            end
          end
        end
      end
    end
  end
end
