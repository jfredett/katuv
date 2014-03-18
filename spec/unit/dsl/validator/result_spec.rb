# encoding: utf-8
require 'spec_helper'

describe Katuv::DSL::Validator::Result do
  subject { Katuv::DSL::Validator::Result.new status: nil }

  describe 'api' do
    # private part of the API, but normally exposed by Anima
    it { should_not respond_to :status }
    it { should respond_to :success? }
    it { should respond_to :failure? }
  end

  describe 'when it is a successful result' do
    subject { Katuv::DSL::Validator::Result.new status: true }

    it { should be_success }
    it { should_not be_failure }

  end

  describe 'when it is a unsuccessful result' do
    subject { Katuv::DSL::Validator::Result.new status: false }

    it { should_not be_success }
    it { should be_failure }
  end
end

