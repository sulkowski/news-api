module News
  module Helpers
    module ResponseHeaders
      def location(location)
        response.headers['Location'] = location
      end
    end
  end
end
