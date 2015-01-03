module News
  module V1
    module Routes
      class Users < Sinatra::Base
        register Sinatra::Namespace

        namespace 'v1' do
          namespace 'users' do
            # post do; end
          end
        end
      end
    end
  end
end
