module News
  module Routes
    class Users < Base
      namespace '/users' do
        post do
          user = User.new(email: params['email'], password: params['password'])
          if user.save!
            status 201
            json user.serializable_hash(only: [:id, :email])
          end
        end
      end
    end
  end
end
