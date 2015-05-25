module News
  module Helpers
    module Authentication
      def authenticate!
        fail User::NotAuthorized unless authorized?
        set_authenticaiton_header
        set_user_email
      end

      def current_user
        News::Models::User.find_by(email: get_user_email)
      end

      def authorized?
        request_auth.provided? &&
          request_auth.basic? &&
          request_auth.credentials &&
          News::Models::User.authorize(
            email:    request_auth.credentials[0],
            password: request_auth.credentials[1]
          )
      end

      private

      def get_user_email
        session[:current_user_email]
      end

      def set_user_email
        session[:current_user_email] = request_auth.credentials[0]
      end

      def set_authenticaiton_header
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      end

      def request_auth
        @request_auth ||= Rack::Auth::Basic::Request.new(request.env)
      end
    end
  end
end
