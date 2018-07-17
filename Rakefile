require "bundler/gem_tasks"
require "rspec/core/rake_task"

# RSpec::Core::RakeTask.new(:spec)

# task :default => :spec

require "rake/testtask"
    Rake::TestTask.new do |t|
      t.name = "test"  # this is the default
      t.libs << "test"  # load the test dir
      t.test_files = Dir['test/*test*.rb']
      t.verbose = true
end
