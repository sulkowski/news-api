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
end
