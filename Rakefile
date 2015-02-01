require 'dotenv/tasks'

task default: %i(spec)

Dir[File.dirname(__FILE__) + '/lib/tasks/*.rb'].sort.each do |path|
  require path
end
