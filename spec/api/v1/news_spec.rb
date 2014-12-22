require 'spec_helper'
require 'api/v1/news'

describe Api::V1::News do
  let(:app) { Rack::Lint.new(Api::V1::News.new) }

  context 'stories' do
    describe '#GET /api/v1/stories' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        get '/api/v1/stories'

        expect(last_response).to be_ok
      end
    end

    describe '#POST /api/v1/stories' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        post '/api/v1/stories'

        expect(last_response).to be_ok
      end
    end

    describe '#GET /api/v1/stories/:id' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        get '/api/v1/stories/1'

        expect(last_response).to be_ok
      end
    end

    describe '#PATCH /api/v1/stories/:id' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        patch '/api/v1/stories/1'

        expect(last_response).to be_ok
      end
    end

    context 'vote' do
      describe '#POST /api/v1/stories/:id/vote/up' do
        it 'returns a successful response' do
          pending 'Not yet implemented'
          post '/api/v1/stories/1/vote/up'

          expect(last_response).to be_ok
        end
      end
      describe '#POST /api/v1/stories/:id/vote/down' do
        it 'returns a successful response' do
          pending 'Not yet implemented'
          post '/api/v1/stories/1/vote/down'

          expect(last_response).to be_ok
        end
      end
      describe '#DELETE /api/v1/stories/:id/vote' do
        it 'returns a successful response' do
          pending 'Not yet implemented'
          delete '/api/v1/stories/1/vote'

          expect(last_response).to be_ok
        end
      end
    end
  end

  context 'users' do
    describe '#POST /api/v1/users' do
      it 'returns a successful response' do
        pending 'Not yet implemented'
        post '/api/v1/users'

        expect(last_response).to be_ok
      end
    end
  end
end
