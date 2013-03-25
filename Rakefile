#!/usr/bin/env rake
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'run specs'
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress"]
end

task :default => :spec
