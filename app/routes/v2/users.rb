module News
  module Routes
    module V2
      class Users < Base
        USER_SERIALIZATION_PARAMS = {
          only: [:id, :email]
        }

        namespace '/users' do
          post do
            user = User.new(email: params['email'], password: params['password'])
            user.save!
            status 201
            respond_with user.serializable_hash(USER_SERIALIZATION_PARAMS)
          end
        end
      end
    end
  end
end
