module News
  module Models
    class Vote < ActiveRecord::Base
      belongs_to :story
      belongs_to :user

      validates :story, presence: true, uniqueness: { scope: :user }
      validates :user,  presence: true

      validates :vote, inclusion: { in: %w(like dislike) }
    end
  end
end
