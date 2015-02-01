module News
  module Routes
    class Stories < Base
      namespace '/stories' do
        get do
          json Story.all
        end

        get '/:id' do
          json Story.find(params[:id])
        end

        patch '/:id' do
        end

        # Voting
        namespace '/:id/vote' do
          put '/up' do
          end

          put '/down' do
          end

          delete do
          end
        end
      end
    end
  end
end
