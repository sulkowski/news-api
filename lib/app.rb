$LOAD_PATH << File.expand_path('../../', __FILE__)
$LOAD_PATH << File.expand_path('../news/v1', __FILE__)

require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

require 'config/environment'
require 'config/database'

require 'models/story'

require 'routes/stories'
require 'routes/users'

module News
  class App < Sinatra::Base
    use V1::Routes::Stories
    use V1::Routes::Users
  end
end
