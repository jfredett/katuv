# encoding: utf-8
require 'crystalline/spec'
require 'rspec/its'

# include helpers
Dir['./spec/helpers/*.rb'].each { |file| require file }

# include shared examples
Dir['./spec/shared/*_examples.rb'].each { |file| require file }

Coveralls.wear! if ENV['COVERALLS']

require 'katuv'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

end

include AST::Sexp
