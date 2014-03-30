require 'spec_helper'

describe Katuv::Utility::Stringulate do

  describe 'creating from snake_case' do
    context 'specifying the input as snake_case' do
      subject { Katuv::Utility::Stringulate.new(snake_case: 'abc_def') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
    context 'using the case-guesser' do
      subject { Katuv::Utility::Stringulate.new('abc_def') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
  end

  describe 'creating from SCREAMING_SNAKE_CASE' do
    context 'specifying the input as SCREAMING_SNAKE_CASE' do
      subject { Katuv::Utility::Stringulate.new(screaming_snake_case: 'ABC_DEF') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
    context 'using the case-guesser' do
      subject { Katuv::Utility::Stringulate.new('ABC_DEF') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
  end

  describe 'creating from camelCase' do
    context 'specifying the input as camelCase' do
      subject { Katuv::Utility::Stringulate.new(camel_case: 'abcDef') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
    context 'using the case-guesser' do
      subject { Katuv::Utility::Stringulate.new('abcDef') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
  end

  describe 'creating from ClassCase' do
    context 'specifying the input as ClassCase' do
      subject { Katuv::Utility::Stringulate.new(class_case: 'AbcDef') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
    context 'using the case-guesser' do
      subject { Katuv::Utility::Stringulate.new('AbcDef') }

      its(:snake_case) { should == 'abc_def' }
      its(:screaming_snake_case) { should == 'ABC_DEF' }
      its(:camel_case) { should == 'abcDef' }
      its(:class_case) { should == 'AbcDef' }
    end
  end
end
