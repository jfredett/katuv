# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Validator::RequiredAssociation do
  subject(:validator) { Katuv::DSL::Validator::RequiredAssociation.new(:example_association_name) }
  let(:node) { double('node') }

  describe '#validate' do
    describe 'when the node validation is successful' do
      context 'with one result' do
        before do
          node.stub(:find_associations_by_name)
            .with(:example_association_name)
            .and_return([double('association')])

          validator.validate(node)
        end

        its(:result) { should be_success }
        its(:result) { should_not be_failure }
      end

      context 'with more than one result' do
        before do
          node.stub(:find_associations_by_name)
            .with(:example_association_name)
            .and_return([double('association'), double('another association')])

          validator.validate(node)
        end

        its(:result) { should be_success }
        its(:result) { should_not be_failure }
      end
    end

    describe 'when the node validation is unsuccessful' do
      context 'with no results' do
        before do
          node.stub(:find_associations_by_name)
            .with(:example_association_name)
            .and_return([])

          validator.validate(node)
        end

        its(:result) { should be_failure }
        its(:result) { should_not be_success }
      end
    end

    specify 'raises when the object does not respond to #find_associations_by_name' do
      expect { validator.validate(node) }.to raise_error NoMethodError
    end
  end
end
