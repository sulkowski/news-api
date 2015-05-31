module News
  module Models
    class Story < ActiveRecord::Base
      belongs_to :user
      has_many :votes

      validates :user, :title, :url, presence: true

      def likes
        votes.where(delta: 1).count
      end

      def dislikes
        votes.where(delta: -1).count
      end
    end
  end
end
