module News
  module Routes
    module Legacy
      class Users < Base
        namespace '/users' do
          post do
            redirect '/v1/users', 301
          end
        end
      end
    end
  end
end
