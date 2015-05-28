require 'spec_helper'

describe News::Routes::Stories do
  let(:user) { User.create(email: 'm@mi6.co.uk', password: 'james') }
  let!(:story) do
    Story.create(
      id: 1,
      user: user,
      title: 'Lorem ipsum',
      url: 'http://www.lipsum.com/'
    )
  end

  describe '#GET `/stories`' do
    before { get '/stories' }

    it 'returns 200 status code' do
      expect(last_response.status).to eq(200)
    end

    it 'has `application/json` content type' do
      expect(last_response.header['Content-Type']).to include('application/json')
    end

    it 'returns stories' do
      first_story = JSON.parse(last_response.body).first

      expect(first_story).to include_json(
        id: 1,
        title: 'Lorem ipsum',
        url: 'http://www.lipsum.com/',
        likes: 0,
        dislikes: 0
      )
    end
  end

  describe '#POST `/stories`' do
    context 'when user is not authorized' do
      it_should_behave_like 'not authorized user' do
        before { post '/stories' }
      end
    end

    context 'when params are valid' do
      before do
        sign_in
        post '/stories', title: 'React.js', url: 'https://facebook.github.io/react/'
      end

      it_should_behave_like 'authorized user'
      it_should_behave_like 'json response'

      it 'returns `201` status code' do
        expect(last_response.status).to eq(201)
      end

      it 'contains `location` header' do
        expect(last_response.header).to have_key('Location')
        expect(last_response.header['Location']).to match(%r{\/stories\/\d+})
      end

      it 'returns a new story in response' do
        expect(last_response.body).to include_json(
          title: 'React.js',
          url: 'https://facebook.github.io/react/',
          likes: 0,
          dislikes: 0
        )
      end
    end

    describe 'url validations' do
      context 'when is not given' do
        before do
          sign_in
          post '/stories', title: 'React.js'
        end

        it_should_behave_like 'json response'

        it 'returns 422 status code' do
          expect(last_response.status).to eq(422)
        end

        it 'returns error description' do
          expect(last_response.body).to include_json(
            error: {
              code: 422,
              message: 'Validation failed: Url can\'t be blank',
              errors: {
                url: ['can\'t be blank']
              }
            }
          )
        end
      end

      describe 'title validations' do
        context 'when is not given' do
          before do
            sign_in
            post '/stories', url: 'https://facebook.github.io/react/'
          end

          it_should_behave_like 'json response'

          it 'returns 422 status code' do
            expect(last_response.status).to eq(422)
          end

          it 'returns error description' do
            expect(last_response.body).to include_json(
              error: {
                code: 422,
                message: 'Validation failed: Title can\'t be blank',
                errors: {
                  title: ['can\'t be blank']
                }
              }
            )
          end
        end
      end
    end
  end

  describe '#GET `/stories/:id`' do
    context 'when the story exists' do
      before { get '/stories/1' }

      it_should_behave_like 'json response'

      it 'returns a successful response' do
        expect(last_response).to be_ok
      end

      it 'returns story as a json' do
        expect(last_response.body).to include_json(
          id: 1,
          title: 'Lorem ipsum',
          url: 'http://www.lipsum.com/',
          likes: 0,
          dislikes: 0
        )
      end
    end

    context 'when the story does not exist' do
      before { get '/stories/0' }

      it_should_behave_like 'json response'

      it 'returns `not found` response' do
        expect(last_response.status).to eq(404)
      end

      it 'contains error message' do
        expect(last_response.body).to include_json(
          error: {
            code: 404,
            message: 'Couldn\'t find News::Models::Story with \'id\'=0'
          }
        )
      end
    end
  end

  describe '#PATCH `/stories/:id`' do
    context 'when didn`t crate the story' do
      before { sign_in }
      before { patch '/stories/1' }

      it_should_behave_like 'json response'

      it 'returns `403` status code' do
        expect(last_response.status).to eq(403)
      end

      it 'contains error message' do
        expect(last_response.body).to include_json(
          error: {
            code: 403,
            message: 'Not allowed to edit story'
          }
        )
      end
    end

    context 'when the user created the story' do
      let(:user) { sign_in }

      describe 'updating `title`' do
        before { patch '/stories/1', title: 'React.js' }

        it_should_behave_like 'authorized user'
        it_should_behave_like 'json response'

        it 'has `200` status code' do
          expect(last_response.status).to eq(200)
        end

        it 'updates the attribute' do
          expect(last_response.body).to include_json(
            id: 1,
            title: 'React.js',
            url: 'http://www.lipsum.com/',
            likes: 0,
            dislikes: 0
          )
        end
      end

      describe 'updating `url`' do
        before { patch '/stories/1', url: 'https://facebook.github.io/react/' }

        it_should_behave_like 'authorized user'
        it_should_behave_like 'json response'

        it 'has `200` status code' do
          expect(last_response.status).to eq(200)
        end

        it 'updates the attribute' do
          expect(last_response.body).to include_json(
            id: 1,
            title: 'Lorem ipsum',
            url: 'https://facebook.github.io/react/',
            likes: 0,
            dislikes: 0
          )
        end
      end
    end
  end

  describe '#PUT `/stories/:id/vote/up`' do
    let!(:current_user) { sign_in }

    context 'when a user already voted for a story' do
      let!(:vote) { Vote.create(user: @current_user, story: story, vote: 'like') }

      before { put '/stories/1/vote/up' }

      it_should_behave_like 'authorized user'

      it 'has `204` status code' do
        expect(last_response.status).to eq(204)
      end

      it 'does not change count of votes for a story' do
        expect(story.likes).to eq(1)
      end
    end

    context 'when a user has not voted for a story' do
      before { put '/stories/1/vote/up' }

      it_should_behave_like 'authorized user'

      it 'has `204` status code' do
        expect(last_response.status).to eq(204)
      end

      it 'changes count of votes for a stroy' do
        expect(story.likes).to eq(1)
      end
    end
  end

  describe '#PUT `/stories/:id/vote/down`' do
    let!(:current_user) { sign_in }

    context 'when a user already voted against a story' do
      let!(:vote) { Vote.create(user: @current_user, story: story, vote: 'dislike') }

      before { put '/stories/1/vote/down' }

      it_should_behave_like 'authorized user'

      it 'has `204` status code' do
        expect(last_response.status).to eq(204)
      end

      it 'does not change count of votes for a story' do
        expect(story.dislikes).to eq(1)
      end
    end

    context 'when a user has not voted against a story' do
      before { put '/stories/1/vote/down' }

      it_should_behave_like 'authorized user'

      it 'has `204` status code' do
        expect(last_response.status).to eq(204)
      end

      it 'changes count of votes for a stroy' do
        expect(story.dislikes).to eq(1)
      end
    end
  end

  describe '#DELETE `stories/:id/vote`' do
    let!(:current_user) { sign_in }
    let!(:vote) { Vote.create(user: @current_user, story: story, vote: 'like') }

    before { delete 'stories/1/vote' }

    it_should_behave_like 'authorized user'

    it 'has `204` status code' do
      expect(last_response.status).to eq(204)
    end

    it 'removes vote of a user' do
      expect(story.likes).to eq(0)
    end
  end
end
