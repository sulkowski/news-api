module News
  module Routes
    class Stories < Base
      STORY_SERIALIZATION_PARAMS = {
        only: [:id, :title, :url],
        methods: [:likes, :dislikes]
      }

      namespace '/stories' do
        get do
          stories = Story.all
          serialized_stories = stories.map { |story| story.serializable_hash(methods: [:likes, :dislikes]) }
          json serialized_stories
        end

        get '/:id' do
          story = Story.find(params[:id])
          json story.serializable_hash(STORY_SERIALIZATION_PARAMS)
        end

        patch '/:id' do
          authenticate!
          story = Story.find(params['id'])
          halt 403, json(error: { code: 403, message: 'Not allowed to edit story' }) unless story.user == current_user

          story.title = params['title'] if params['title']
          story.url   = params['url']   if params['url']
          story.save!
          status 200
          json story.serializable_hash(STORY_SERIALIZATION_PARAMS)
        end

        post do
          authenticate!

          story = Story.new(user: current_user, title: params['title'], url: params['url'])
          story.save!
          status 201
          location "/stories/#{story.id}"
          json story.serializable_hash(STORY_SERIALIZATION_PARAMS)
        end

        # Voting
        namespace '/:id/vote' do
          before do
            authenticate!
            @story = Story.find(params['id'])
          end

          put '/up' do
            Vote.find_or_create_by(story: @story, user: current_user) do |vote|
              vote.vote = 'like'
            end

            status 204
          end

          put '/down' do
            Vote.find_or_create_by(story: @story, user: current_user) do |vote|
              vote.vote = 'dislike'
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
