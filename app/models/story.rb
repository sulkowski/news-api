module News
  module Models
    class Story < ActiveRecord::Base
      belongs_to :user
      has_many :votes, dependent: :destroy

      validates :user, :title, :url, presence: true

      scope :recent,  ->(limit) { order('created_at DESC').limit(limit) }
      scope :popular, ->(limit) { joins(:votes).group(:id).order('SUM(votes.delta) DESC').limit(limit) }

      def likes
        votes.where(delta: 1).count
      end

      def dislikes
        votes.where(delta: -1).count
      end
    end
  end
end
