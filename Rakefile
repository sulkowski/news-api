require 'active_record'
require 'dotenv/tasks'
require 'rspec/core/rake_task'

task default: %i(spec)

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--color'
  task.verbose    = false
end

namespace :db do
  task connect: :dotenv do
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
  end

  task migrate: :connect do
    ActiveRecord::Migrator.migrate('db/migrate', ENV['VERSION'] ? ENV['VERSION'].to_i : nil)
  end

  task rollback: :connect do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback 'db/migrate', step
  end
end
