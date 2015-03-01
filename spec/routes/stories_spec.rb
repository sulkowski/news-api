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

  describe '#POST `/stories`'

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

  describe '#PATCH `/stories/:id`'

  describe 'voting' do
    describe '#PUT `/stories/:id/vote/up`'
    describe '#PUT `/stories/:id/vote/down`'
    describe '#DELETE `stories/:id/vote`'
  end
end
