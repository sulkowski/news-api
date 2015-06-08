require 'spec_helper'

describe News::Routes::Legacy::Stories do
  describe '#GET /stories' do
    before { get '/stories' }

    it_should_behave_like 'legacy endpoint'
  end

  describe '#GET /stories/:id' do
    before { get '/stories/1' }

    it_should_behave_like 'legacy endpoint'
  end

  describe '#PATCH /stories/:id' do
    before { patch '/stories/1' }

    it_should_behave_like 'legacy endpoint'
  end

  describe '#GET /stories/:id/url' do
    before { get '/stories/1/url' }

    it_should_behave_like 'legacy endpoint'
  end

  describe '#PUT /stories/:id/vote/up' do
    before { put '/stories/1/vote/up' }

    it_should_behave_like 'legacy endpoint'
  end

  describe '#PUT /stories/:id/vote/down' do
    before { put '/stories/1/vote/down' }

    it_should_behave_like 'legacy endpoint'
  end

  describe '#DELETE /stories/:id/vote' do
    before { delete '/stories/1/vote' }

    it_should_behave_like 'legacy endpoint'
  end
end
