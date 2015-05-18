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

        post do
          authenticate!

          story = Story.new(title: params['title'], url: params['url'])
          if story.save!
            status 201
            location "/stories/#{story.id}"
            json story
          end
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
