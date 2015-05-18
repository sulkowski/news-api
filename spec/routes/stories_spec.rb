require 'spec_helper'

describe News::Routes::Stories do
  before {
    Story.create(
      id: 1,
      title: 'Lorem ipsum',
      url: 'http://www.lipsum.com/'
    )
  }

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
        url: 'http://www.lipsum.com/'
      )
    end
  end

  describe '#POST `/stories`' do
    context 'when user is not authorized' do
      it_should_behave_like 'not authorized user' do
        before {
          post '/stories'
        }
      end
    end

    context 'when params are valid' do
      before {
        sign_in
        post '/stories', title: 'React.js', url: 'https://facebook.github.io/react/'
      }

      it 'returns `201` status code' do
        expect(last_response.status).to eq(201)
      end

      it 'has `application/json` content-type' do
        expect(last_response.header['Content-Type']).to include('application/json')
      end

      it 'contains `location` header' do
        expect(last_response.header).to have_key('Location')
        expect(last_response.header['Location']).to match(%r{\/stories\/\d+})
      end

      it 'returns a new story in response' do
        expect(last_response.body).to include_json(
          title: 'React.js',
          url: 'https://facebook.github.io/react/'
        )
      end
    end

    describe 'url validations' do
      context 'when is not given' do
        before {
          sign_in
          post '/stories', title: 'React.js'
        }

        it 'returns 422 status code' do
          expect(last_response.status).to eq(422)
        end

        it 'has `application/json` content-type' do
          expect(last_response.header['Content-Type']).to include('application/json')
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
          before {
            sign_in
            post '/stories', url: 'https://facebook.github.io/react/'
          }

          it 'returns 422 status code' do
            expect(last_response.status).to eq(422)
          end

          it 'has `application/json` content-type' do
            expect(last_response.header['Content-Type']).to include('application/json')
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

      it 'returns a successful response' do
        expect(last_response).to be_ok
      end

      it 'has `application/json` content-type' do
        expect(last_response.header['Content-Type']).to include('application/json')
      end

      it 'returns story as a json' do
        expect(last_response.body).to include_json(
          id: 1,
          title: 'Lorem ipsum',
          url: 'http://www.lipsum.com/'
        )
      end
    end

    context 'when the story does not exist' do
      before { get '/stories/15' }

      it 'returns `not found` response' do
        expect(last_response.status).to eq(404)
      end

      it 'has `application/json` content-type' do
        expect(last_response.header['Content-Type']).to eq('application/json')
      end

      it 'contains error message' do
        expect(last_response.body).to include_json(
          error: {
            code: 404,
            message: 'Couldn\'t find News::Models::Story with \'id\'=15'
          }
        )
      end
    end
  end

  describe '#PATCH `/stories/:id`' do
    xit 'updates a story' do
      patch '/stories/1', title: 'React.js', url: 'https://facebook.github.io/react/'

      expect(last_response.body).to include_json(
        id: 1,
        title: 'React.js',
        url: 'https://facebook.github.io/react/'
      )
    end
  end

  describe 'voting' do
    describe '#PUT `/stories/:id/vote`' do
      context 'when a user already voted for a story' do
        xit 'does not change count of votes for a story' do
          put '/stories:/1/vote', count: 1
        end
      end

      context 'when a user has not voted for a story' do
        xit 'changes count of votes for a stroy' do
          put '/stories:/1/vote', count: 1
        end
      end

      context 'when a user alredy voted against a story' do
        xit 'does not change count of votes for a story' do
          put '/stories:/1/vote', count: -1
        end
      end

      context 'when a user has not voted against a story' do
        xit 'changes count of votes for a stroy' do
          put '/stories:/1/vote', count: -1
        end
      end
    end

    describe '#DELETE `stories/:id/vote`' do
      xit 'removes vote of a user' do
        delete 'stories/:id/vote'
      end
    end
  end
end
