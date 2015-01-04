require_relative 'base'

module News
  module V1
    module Routes
      class Users < Base
        namespace 'v1' do
          namespace 'users' do
            # post do; end
          end
        end
      end
    end
  end
end
