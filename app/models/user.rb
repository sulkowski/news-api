require 'bcrypt'

module News
  module Models
    class User < ActiveRecord::Base
      include BCrypt

      validates :email, :password, presence: true

      def password
        return unless password_hash
        @password ||= Password.new(password_hash)
      end

      def password=(new_password)
        @password = Password.create(new_password)
        self.password_hash = @password
      end
    end
  end
end
