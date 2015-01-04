require_relative 'base'

module News
  module V1
    module Routes
      class Stories < Base
        namespace '/v1' do
          namespace '/stories' do
            get do
              json Story.all
            end

            # post do; end

            get '/:id' do
              json Story.find(params[:id])
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
