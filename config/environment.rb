require 'dotenv'

APP_ENV = ENV.fetch('RACK_ENV')

Dotenv.load(".env.#{APP_ENV}", '.env')
