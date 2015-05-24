require 'spec_helper'

describe News::Models::Story do
  describe 'validations' do
    let(:story) { Story.new(id: 1, title: 'Lorem ipsum', url: 'http://www.lipsum.com/') }

    it 'is valid with with all attributes' do
      expect(story).to be_valid
    end

    describe 'title arrtibute' do
      context 'when `title` is not present' do
        it 'is not valid' do
          story.title = nil
          expect(story).to_not be_valid
        end
      end
    end

    describe 'url attribute' do
      context 'when `url` is not present' do
        it 'is not valid' do
          story.url = nil
          expect(story).to_not be_valid
        end
      end
    end
  end
end
