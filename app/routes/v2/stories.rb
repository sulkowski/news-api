module News
  module Routes
    module V2
      class Stories < Base
        STORY_SERIALIZATION_PARAMS = {
          only: [:id, :title, :url],
          methods: [:likes, :dislikes]
        }

        namespace '/stories' do
          get do
            stories = Story.all
            serialized_stories = stories.map { |story| story.serializable_hash(methods: [:likes, :dislikes]) }
            respond_with serialized_stories
          end

          get '/:id' do
            story = Story.find(params[:id])
            respond_with story.serializable_hash(STORY_SERIALIZATION_PARAMS)
          end

          patch '/:id' do
            authenticate!
            story = Story.find(params['id'])
            fail News::Exceptions::AuthorizationError unless story.user == current_user

            story.update!(params.slice('title', 'url'))
            status 200
            respond_with story.serializable_hash(STORY_SERIALIZATION_PARAMS)
          end

          post do
            authenticate!

            story = Story.new(user: current_user, title: params['title'], url: params['url'])
            story.save!
            status 201
            location "/stories/#{story.id}"
            respond_with story.serializable_hash(STORY_SERIALIZATION_PARAMS)
          end

          get '/:id/url' do
            story = Story.find(params['id'])

            redirect story.url, 303
          end

          namespace '/:id/vote' do
            before do
              authenticate!
              @story = Story.find(params['id'])
            end

            put '/up' do
              Vote.find_or_create_by(story: @story, user: current_user) do |vote|
                vote.delta = 1
              end

              status 204
            end

            put '/down' do
              Vote.find_or_create_by(story: @story, user: current_user) do |vote|
                vote.delta = -1
              end

              status 204
            end

            delete do
              Vote.delete_all(story: @story, user: current_user)

              status 204
            end
          end
        end
      end
    end
  end
end
