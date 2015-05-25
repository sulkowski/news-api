require 'spec_helper'

describe News::Models::Vote do
  describe 'validations' do
    let(:user)  { User.create(email: '007@mi6.co.uk', password: 'vesper')  }
    let(:story) { Story.create(id: 1, user: user, title: 'Lorem ipsum', url: 'http://www.lipsum.com/') }
    let(:vote_params) { { user: user, story: story, vote: 'like' } }

    context 'when there already exists vote for given user and story' do
      before { Vote.create(vote_params) }

      it 'is not valid' do
        expect(Vote.new(vote_params)).to_not be_valid
      end
    end

    describe 'user arrtibute' do
      context 'when `title` is not present' do
        it 'is not valid' do
          vote_params[:user] = nil
          expect(Vote.new(vote_params)).to_not be_valid
        end
      end
    end

    describe 'story arrtibute' do
      context 'when `title` is not present' do
        it 'is not valid' do
          vote_params[:story] = nil
          expect(Vote.new(vote_params)).to_not be_valid
        end
      end
    end

    describe 'vote attribute' do
      context 'when `vote` equals `like`' do
        it 'is valid' do
          vote_params[:vote] = 'like'
          expect(Vote.new(vote_params)).to be_valid
        end
      end

      context 'when `vote` equals `dislike`' do
        it 'is valid' do
          vote_params[:vote] = 'dislike'
          expect(Vote.new(vote_params)).to be_valid
        end
      end
    end
  end
end
