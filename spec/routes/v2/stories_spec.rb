require 'spec_helper'

describe News::Routes::V2::Stories do
  let(:accept_header) { { 'HTTP_ACCEPT' => 'application/vnd.news-app.v2+json' } }
  let(:user_params) do
    { email: 'm@mi6.co.uk', password: 'james' }
  end
  let(:story_params) do
    {
      id: 1,
      user: user,
      title: 'Lorem ipsum',
      url: 'http://www.lipsum.com/'
    }
  end

  describe '#GET `/stories`' do
    let(:user)   { User.create(user_params) }
    let!(:story) { Story.create(story_params) }

    describe 'json response' do
      before { get '/stories', {}, accept_header }

      it_should_behave_like 'json response'

      it 'returns correct status code and stories' do
        first_story = JSON.parse(last_response.body).first

        expect(last_response.status).to eq(200)
        expect(first_story).to include_json(
          id: 1,
          title: 'Lorem ipsum',
          url: 'http://www.lipsum.com/',
          likes: 0,
          dislikes: 0
        )
      end
    end

    describe 'xml response' do
      before { get '/stories', {}, 'HTTP_ACCEPT' => 'application/vnd.news-app.v2+xml' }

      it_should_behave_like 'xml response'

      it 'returns correct status code and stories' do
        stories = Hash.from_xml(last_response.body)['objects']
        first_story = stories[0]

        expect(last_response.status).to eq(200)
        expect(first_story['id']).to eq(1)
        expect(first_story['title']).to eq('Lorem ipsum')
        expect(first_story['url']).to eq('http://www.lipsum.com/')
        expect(first_story['likes']).to eq(0)
        expect(first_story['dislikes']).to eq(0)
      end
    end
  end

  describe '#POST `/stories`' do
    context 'when user is not authorized' do
      it_should_behave_like 'not authorized user' do
        before { post '/stories', {}, accept_header }
      end
    end

    context 'when params are valid' do
      before { sign_in }
      before { post '/stories', { title: 'React.js', url: 'https://facebook.github.io/react/' }, accept_header }

      it_should_behave_like 'authorized user'
      it_should_behave_like 'json response'

      it 'returns correct status code, location header and a new story in response' do
        expect(last_response.status).to eq(201)
        expect(last_response.header['Location']).to match(%r{\/stories\/\d+})
        expect(last_response.body).to include_json(
          title: 'React.js',
          url: 'https://facebook.github.io/react/',
          likes: 0,
          dislikes: 0
        )
      end
    end

    context 'when params are not valid' do
      before { sign_in }
      before { post '/stories', {}, accept_header }

      it_should_behave_like 'json response'

      it 'returns correct status code and error description' do
        expect(last_response.status).to eq(422)
        expect(last_response.body).to include_json(
          error: {
            code: 422,
            message: 'Validation failed: Title can\'t be blank, Url can\'t be blank',
            errors: {
              title: ['can\'t be blank'],
              url: ['can\'t be blank']
            }
          }
        )
      end
    end
  end

  describe '#GET `/stories/:id`' do
    context 'when the story exists' do
      let(:user)   { User.create(user_params) }
      let!(:story) { Story.create(story_params) }

      before { get '/stories/1', {}, accept_header }

      it_should_behave_like 'json response'

      it 'returns correct status code story' do
        expect(last_response.status).to eq(200)
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
      it_should_behave_like 'json response'

      before { get '/stories/1', {}, accept_header }

      it 'returns correct status code and error message' do
        expect(last_response.status).to eq(404)
        expect(last_response.body).to include_json(
          error: {
            code: 404,
            message: 'Couldn\'t find News::Models::Story with \'id\'=1'
          }
        )
      end
    end
  end

  describe '#PATCH `/stories/:id`' do
    context 'when the story does not belong to the user' do
      let(:user)   { User.create(user_params) }
      let!(:story) { Story.create(story_params) }

      before { sign_in }
      before { patch '/stories/1', {}, accept_header }

      it_should_behave_like 'json response'

      it 'returns correct status code and error message' do
        expect(last_response.status).to eq(403)
        expect(last_response.body).to include_json(
          error: {
            code: 403,
            message: 'Not authorized'
          }
        )
      end
    end

    context 'when the story belongs to the user' do
      let(:user)   { sign_in }
      let!(:story) { Story.create(story_params) }

      before { patch '/stories/1', { title: 'React.js', url: 'https://facebook.github.io/react/' }, accept_header }

      it_should_behave_like 'authorized user'
      it_should_behave_like 'json response'

      it 'returns correct status code adn updates the attributes' do
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include_json(
          id: 1,
          title: 'React.js',
          url: 'https://facebook.github.io/react/',
          likes: 0,
          dislikes: 0
        )
      end
    end
  end

  describe '#DELETE /stories/:id' do
    context 'when the story does not belong to the user' do
      let(:user)   { User.create(user_params) }
      let!(:story) { Story.create(story_params) }

      before { sign_in }
      before { patch '/stories/1', {}, accept_header }

      it_should_behave_like 'json response'

      it 'returns correct status code and error message' do
        expect(last_response.status).to eq(403)
        expect(last_response.body).to include_json(
          error: {
            code: 403,
            message: 'Not authorized'
          }
        )
      end
    end

    context 'when the story belongs to the user' do
      let(:user)   { sign_in }
      let!(:story) { Story.create(story_params) }

      before { delete '/stories/1', {}, accept_header }

      it 'returns correct status code adn updates the attributes' do
        expect(last_response.status).to eq(200)
        expect(last_response.body).to include_json(
          id: 1,
          title: 'Lorem ipsum',
          url: 'http://www.lipsum.com/',
          likes: 0,
          dislikes: 0
        )
      end
    end
  end

  describe '#GET `/stories/:id/url`' do
    context 'when a stroy does not exist' do
      before { get '/stories/1/url' }

      it 'returns 404 status code' do
        expect(last_response.status).to eq(404)
      end
    end

    context 'when a story exists' do
      let(:user)   { User.create(user_params) }
      let!(:story) { Story.create(story_params) }

      before { get '/stories/1/url', {}, accept_header }

      it 'returns correct status code and location header' do
        expect(last_response.location).to eq('http://www.lipsum.com/')
        expect(last_response.status).to eq(303)
      end
    end
  end

  describe '#PUT `/stories/:id/vote/up`' do
    let(:user)   { sign_in }
    let!(:story) { Story.create(story_params) }

    before { put '/stories/1/vote/up', {}, accept_header }

    it_should_behave_like 'authorized user'

    context 'when a user has not voted for a story' do
      it 'returns correct status code changes count of votes for a stroy' do
        expect(last_response.status).to eq(204)
        expect(story.likes).to eq(1)
      end
    end

    context 'when a user already voted for a story' do
      let!(:vote) { Vote.create(user: user, story: story, delta: 1) }

      it 'returns correct status code and does not change count of votes' do
        expect(last_response.status).to eq(204)
        expect(story.likes).to eq(1)
      end
    end

    context 'when user already voted against the story' do
      let!(:vote) { Vote.create(user: user, story: story, delta: -1) }

      it 'returns correct status code and changes count of likes and dislikes' do
        expect(last_response.status).to eq(204)
        expect(story.likes).to eq(1)
        expect(story.dislikes).to eq(0)
      end
    end
  end

  describe '#PUT `/stories/:id/vote/down`' do
    let(:user)   { sign_in }
    let!(:story) { Story.create(story_params) }

    before { put '/stories/1/vote/down', {}, accept_header }

    it_should_behave_like 'authorized user'

    context 'when a user already voted against a story' do
      let!(:vote) { Vote.create(user: user, story: story, delta: -1) }

      it 'returns correct status code does not change count of votes' do
        expect(last_response.status).to eq(204)
        expect(story.dislikes).to eq(1)
      end
    end

    context 'when user already voted for the story' do
      let!(:vote) { Vote.create(user: user, story: story, delta: 1) }

      it 'returns correct status code and changes count of likes and dislikes' do
        expect(last_response.status).to eq(204)
        expect(story.dislikes).to eq(1)
        expect(story.likes).to eq(0)
      end
    end

    context 'when a user has not voted against a story' do
      it 'returns correct status code and changes count of dislikes' do
        expect(last_response.status).to eq(204)
        expect(story.dislikes).to eq(1)
      end
    end
  end

  describe '#DELETE `/stories/:id/vote`' do
    let(:user)   { sign_in }
    let!(:story) { Story.create(story_params) }
    let!(:vote)  { Vote.create(user: user, story: story, delta: 1) }

    before { delete '/stories/1/vote', {}, accept_header }

    it_should_behave_like 'authorized user'

    it 'returns correct status code and removes vote of a user' do
      expect(last_response.status).to eq(204)
      expect(story.likes).to eq(0)
    end
  end
end
