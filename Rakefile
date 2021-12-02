require 'rake'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
  # Ignored
end

require 'active_record_migrations'
ActiveRecordMigrations.configure do |c|
  c.schema_format = :sql # default is :ruby
  c.yaml_config = 'config/database.yml'
end

ActiveRecordMigrations.load_tasks
