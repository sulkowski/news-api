require 'bcrypt'

module News
  module Models
    class User < ActiveRecord::Base
      include BCrypt

      validates :email,    presence: true, uniqueness: true
      validates :password, presence: true

      def self.authorize(email:, password:)
        user = User.where(email: email).first
        return false unless user
        user.password == password
      end

      def password
        @password ||= password_hash.present? ? Password.new(password_hash) : password_hash
      end

      def password=(new_password)
        @password = new_password.present? ? Password.create(new_password) : new_password
        self.password_hash = @password
      end
    end
  end
end
