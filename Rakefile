require 'rspec/core/rake_task'

task default: %i(spec)

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = '--color'
  task.verbose    = false
end
