module News
  module Models
    class Story < ActiveRecord::Base
      belongs_to :user
      has_many :votes

      validates :user, :title, :url, presence: true

      def likes
        votes.where(vote: 'like').count
      end

      def dislikes
        votes.where(vote: 'dislike').count
      end
    end
  end
end
