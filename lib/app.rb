$LOAD_PATH << File.expand_path('../../', __FILE__)
$LOAD_PATH << File.expand_path('../news/v1', __FILE__)

require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

require 'routes/stories'
require 'routes/users'

class App < Sinatra::Base
  use News::V1::Routes::Stories
  use News::V1::Routes::Users
end
