require 'spec_helper'

describe News::Models::Story do
  describe 'validations' do
    let(:user)  { User.create(email: '007@mi6.co.uk', password: 'vesper')  }
    let(:story_params) { { user: user, title: 'Lorem ipsum', url: 'http://www.lipsum.com/' } }

    describe 'user arrtibute' do
      context 'when `title` is not present' do
        it 'is not valid' do
          story_params[:user] = nil
          expect(Story.new(story_params)).to_not be_valid
        end
      end
    end

    describe 'title arrtibute' do
      context 'when `title` is not present' do
        it 'is not valid' do
          story_params[:title] = nil
          expect(Story.new(story_params)).to_not be_valid
        end
      end
    end

    describe 'url attribute' do
      context 'when `url` is not present' do
        it 'is not valid' do
          story_params[:url] = nil
          expect(Story.new(story_params)).to_not be_valid
        end
      end
    end
  end

  describe '.recent' do
    let!(:user)    { User.create(email: '007@mi6.co.uk', password: 'vesper') }
    let!(:story_1) { Story.create(title: 'A', url: 'https://pilot.co/a', created_at: 3.days.ago, user: user) }
    let!(:story_2) { Story.create(title: 'B', url: 'https://pilot.co/b', created_at: 10.days.ago, user: user) }
    let!(:story_3) { Story.create(title: 'C', url: 'https://pilot.co/c', created_at: 4.days.ago, user: user) }

    it 'returns n most recent stories' do
      recent_stories = Story.recent(2)

      expect(recent_stories).to eq([story_1, story_3])
    end
  end

  describe '.popular' do
    let!(:user_1) { User.create(email: '007@mi6.co.uk', password: 'vesper') }
    let!(:user_2) { User.create(email: '008@mi6.co.uk', password: 'vesper_2') }
    let!(:user_3) { User.create(email: '009@mi6.co.uk', password: 'vesper_3') }
    let!(:user_4) { User.create(email: '010@mi6.co.uk', password: 'vesper_4') }

    let!(:story_1)  { Story.create(title: 'A', url: 'https://pilot.co/a', user: user_1) }
    let!(:story_2)  { Story.create(title: 'B', url: 'https://pilot.co/b', user: user_1) }
    let!(:story_3)  { Story.create(title: 'C', url: 'https://pilot.co/c', user: user_1) }

    let!(:vote_1_1) { Vote.create(story: story_1, user: user_1, delta: 1) }

    let!(:vote_2_1) { Vote.create(story: story_2, user: user_1, delta: 1) }
    let!(:vote_2_2) { Vote.create(story: story_2, user: user_2, delta: 1) }
    let!(:vote_2_3) { Vote.create(story: story_2, user: user_3, delta: -1) }
    let!(:vote_2_4) { Vote.create(story: story_2, user: user_4, delta: -1) }

    let!(:vote_3_1) { Vote.create(story: story_3, user: user_1, delta: 1) }
    let!(:vote_3_2) { Vote.create(story: story_3, user: user_2, delta: 1) }

    it 'returns 2 most popular stories' do
      popular_stories = Story.popular(2)

      expect(popular_stories).to eq([story_3, story_1])
    end
  end
end
