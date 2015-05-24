module News
  module Helpers
    module Authentication
      def authenticate!
        fail User::NotAuthorized unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      end

      def authorized?
        @auth ||= Rack::Auth::Basic::Request.new(request.env)
        @auth.provided? &&
          @auth.basic? &&
          @auth.credentials &&
          News::Models::User.authorize(
            email:    @auth.credentials[0],
            password: @auth.credentials[1]
          )
      end
    end
  end
end
