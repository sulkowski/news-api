require 'spec_helper'
require 'app'

describe News::App do
  let(:app) { Rack::Lint.new(News::App.new) }

  context 'stories' do
    before(:each) { Story.create!(id: 1, title: 'Lorem ipsum', url: 'http://www.lipsum.com/') }

    describe '#GET /v1/stories' do
      before(:each) { get '/v1/stories' }

      it 'returns a successful response' do
        expect(last_response).to be_ok
      end

      it 'returns `application/json` content type' do
        expect(last_response.header['Content-Type']).to eq('application/json')
      end

      it 'returns correct response body' do
        expect(last_response.body).to eq("\{\"note\"\:\"Requested: /v1/stories\"\}")
      end
    end

    describe '#POST /v1/stories' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        post '/v1/stories'

        expect(last_response).to be_ok
      end
    end

    describe '#GET /v1/stories/:id' do
      before(:each) { get '/v1/stories/1' }

      it 'returns a successful response' do
        expect(last_response).to be_ok
      end

      it 'returns `application/json` content type' do
        expect(last_response.header['Content-Type']).to eq('application/json')
      end

      it 'returns correct response body' do
        expect(last_response.body).to eq("\{\"note\"\:\"Requested: /v1/stories/1\"\}")
      end
    end

    describe '#PATCH /v1/stories/:id' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        patch '/v1/stories/1'

        expect(last_response).to be_ok
      end
    end

    context 'vote' do
      describe '#PUT /v1/stories/:id/vote/up' do
        it 'returns a successful response' do
          pending 'Not yet implemented'
          post '/v1/stories/1/vote/up'

          expect(last_response).to be_ok
        end
      end
      describe '#PUT /v1/stories/:id/vote/down' do
        it 'returns a successful response' do
          pending 'Not yet implemented'
          post '/v1/stories/1/vote/down'

          expect(last_response).to be_ok
        end
      end
      describe '#DELETE /v1/stories/:id/vote' do
        it 'returns a successful response' do
          pending 'Not yet implemented'
          delete '/v1/stories/1/vote'

          expect(last_response).to be_ok
        end
      end
    end
  end

  context 'users' do
    describe '#POST /v1/users' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        post '/v1/users'

        expect(last_response).to be_ok
      end
    end
  end
end
