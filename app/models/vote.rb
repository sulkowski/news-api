module News
  module Models
    class Vote < ActiveRecord::Base
      belongs_to :story
      belongs_to :user

      validates :story, presence: true, uniqueness: { scope: :user }
      validates :user,  presence: true

      validates :delta, inclusion: { in: [1, -1] }
    end
  end
end
