require 'active_record'
require 'dotenv'
require 'dotenv/deployment'

namespace :db do
  task connect: :dotenv do
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end

  task migrate: :connect do
    ActiveRecord::Migrator.migrate('db/migrations', ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
  end

  task rollback: :connect do
    ActiveRecord::Migrator.rollback 'db/migrations', ENV['STEP'] ? ENV['STEP'].to_i : 1
  end
end
