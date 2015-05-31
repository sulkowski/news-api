module News
  module Helpers
    module Authentication
      def authenticate!
        fail News::Exceptions::AuthenticationError unless authorized?
        set_authenticaiton_header
      end

      def current_user
        @current_user ||= News::Models::User.find_by(email: user_email)
      end

      def authorized?
        request_auth.provided? &&
          request_auth.basic? &&
          request_auth.credentials &&
          News::Models::User.authorize(
            email:    user_email,
            password: user_password
          )
      end

      private

      def user_email
        @user_email ||= request_auth.credentials[0]
      end

      def user_password
        @user_password ||= request_auth.credentials[1]
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
