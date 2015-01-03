require 'sinatra/base'
require 'sinatra/json'

require_relative 'news/v1/routes/stories'
require_relative 'news/v1/routes/users'

class App < Sinatra::Base
  use News::V1::Routes::Stories
  use News::V1::Routes::Users
end
