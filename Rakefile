# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rubygems'
require 'rspec/core/rake_task'
require 'yard'

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/unit/**/*_spec.rb'
  t.rspec_opts = %w[--color]
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
end

task :default => [:spec]
