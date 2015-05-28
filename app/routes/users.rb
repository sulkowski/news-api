module News
  module Routes
    class Users < Base
      USER_SERIALIZATION_PARAMS = {
        only: [:id, :email]
      }

      namespace '/users' do
        post do
          user = User.new(email: params['email'], password: params['password'])
          user.save!
          status 201
          json user.serializable_hash(USER_SERIALIZATION_PARAMS)
        end
      end
    end
  end
end
