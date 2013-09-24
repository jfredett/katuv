# encoding: utf-8
require 'crystalline/spec'

# include helpers
Dir['./spec/helpers/*.rb'].each { |file| require file }

# include shared examples
Dir['./spec/shared/*_examples.rb'].each { |file| require file }

Coveralls.wear! if ENV['COVERALLS']

Crystalline::Spec.install!

require 'katuv'

include AST::Sexp
