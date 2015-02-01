module News
  module Helpers
    class ActiveRecordErrorResolver < Sinatra::Application
      error ActiveRecord::RecordNotFound do
        status 404
        json error: 'Record not found.'
      end
    end
  end
end
