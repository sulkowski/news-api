module News
  module V1
    module Routes
      class Stories < Sinatra::Base
        helpers Sinatra::JSON
        register Sinatra::Namespace

        namespace '/v1' do
          namespace '/stories' do
            get do
              json note: 'Requested: /v1/stories'
            end

            # post do; end

            get '/:id' do
              json note: "Requested: /v1/stories/#{params[:id]}"
            end

            # patch '/:id' do; end

            namespace '/:id/vote' do
              # put '/up' do; end
              # put '/down' do; end
              # delete do; end
            end
          end
        end
      end
    end
  end
end
