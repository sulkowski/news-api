module News
  module Exceptions
    AuthenticationError = Class.new(StandardError)
    AuthorizationError  = Class.new(StandardError)
  end
end
