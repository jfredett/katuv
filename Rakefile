#!/usr/bin/env rake
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'run specs'
RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress"]
end

task :default => :spec


task :flog do
  puts "#### FLOG ####"
  system 'flog lib/*'
  puts "##############"
end

task :flay do
  puts "#### FLAY ####"
  system 'flay lib/*'
  puts "##############"
end

task :mutant, [:klass] do |_, args|
  puts "#### MUTANT TESTING ####"
  system "mutant -I lib -r katuv --rspec-full #{args[:name] || '::Katuv'}"
  puts "########################"
end

task :metrics => [:flog, :flay]


task :all => [:spec, :mutant, :metrics]
