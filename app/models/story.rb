module News
  module Models
    class Story < ActiveRecord::Base
      validates :title, :url, presence: true
    end
  end
end
