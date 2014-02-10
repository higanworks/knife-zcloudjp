# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rubygems'
require "bundler/gem_tasks"
require 'rspec/core/rake_task'

desc "Run all specs in spec directory"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/unit/**/*_spec.rb'
  t.rspec_opts = %w[--color]
end

task :default => [:spec]
