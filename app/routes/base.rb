module News
  module Routes
    class Base < Sinatra::Application
      configure do
        set :root, App.root
      end

      use Helpers::ActiveRecordErrorResolver
    end
  end
end
