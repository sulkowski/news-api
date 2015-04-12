require 'spec_helper'

describe News::Routes::Stories do
  before(:each) {
    @story = Story.create(id: 1, title: 'Lorem ipsum', url: 'http://www.lipsum.com/')
  }

  describe '#GET `/stories`' do
    before(:each) { get '/stories' }

    it 'returns a successful response' do
      expect(last_response).to be_ok
    end

    it 'has `application/json` content type' do
      expect(last_response.header['Content-Type']).to eq('application/json')
    end

    it 'returns stories as a json' do
      response = JSON.parse(last_response.body).first
      expect(response['id']).to eq(1)
      expect(response['title']).to eq('Lorem ipsum')
      expect(response['url']).to eq('http://www.lipsum.com/')
    end
  end

  describe '#POST `/stories`' do
    xit 'creates a new story' do
      post '/stories', title: 'React.js', url: 'https://facebook.github.io/react/'

      response = JSON.parse(last_response.body)
      expect(response['title']).to eq('React.js')
      expect(response['url']).to eq('https://facebook.github.io/react/')
    end
  end

  describe '#GET `/stories/:id`' do
    context 'when the story exists' do
      before(:each) { get '/stories/1' }

      it 'returns a successful response' do
        expect(last_response).to be_ok
      end

      it 'has `application/json` content type' do
        expect(last_response.header['Content-Type']).to eq('application/json')
      end

      it 'returns story as a json' do
        response = JSON.parse(last_response.body)
        expect(response['id']).to eq(1)
        expect(response['title']).to eq('Lorem ipsum')
        expect(response['url']).to eq('http://www.lipsum.com/')
      end
    end

    context 'when the story does not exist' do
      before(:each) { get '/stories/15' }

      it 'returns `not found` response' do
        expect(last_response).to be_not_found
      end

      it 'has `application/json` content type' do
        expect(last_response.header['Content-Type']).to eq('application/json')
      end

      it 'contains error message' do
        expect(JSON.parse(last_response.body)).to eq('error' => 'Record not found.')
      end
    end
  end

  describe '#PATCH `/stories/:id`' do
    xit 'updates a story' do
      patch '/stories/1', title: 'React.js', url: 'https://facebook.github.io/react/'

      response = JSON.parse(last_response.body)
      expect(response['title']).to eq('React.js')
      expect(response['url']).to eq('https://facebook.github.io/react/')
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
