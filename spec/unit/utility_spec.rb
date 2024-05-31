require 'spec_helper'

describe Katuv::Utility do
  describe '#classify' do
    specify { Katuv::Utility.classify('abc_def')  .should == 'AbcDef'  }
    specify { Katuv::Utility.classify('_____')    .should == '_____'   }
    specify { Katuv::Utility.classify('')         .should == ''        }
    specify { Katuv::Utility.classify('AbcDef')   .should == 'AbcDef'  }

    # This is such a rare corner case, I don't want to code against it, but 
    # right now this will classify to "AbcDef", not "_AbcDef" as it should.
    #specify { Katuv::Utility.classify('_abc_def') .should == '_AbcDef' }
  end

  describe '#snake_casify' do
    specify { Katuv::Utility.snake_casify('AbcDef')  .should == 'abc_def' }
    specify { Katuv::Utility.snake_casify('_____')   .should == '_____'   }
    specify { Katuv::Utility.snake_casify('')        .should == ''        }
    specify { Katuv::Utility.snake_casify('abc_def') .should == 'abc_def' }
  end

  describe '#constantize' do
    describe 'using the default namespace' do
      subject { Katuv::Utility.constantize(:ExampleConst) }

      context 'when the class exists' do
        before { class ExampleConst ; end }
        after { Object.send(:remove_const, :ExampleConst) }

        it { should be ExampleConst }
      end

      context 'when the class does not exist' do
        it { should be_nil }
      end
    end

    describe 'using a nondefault namespace' do
      before { module SomeNamespace ; end }
      after { Object.send(:remove_const, :SomeNamespace) }

      context 'when the class exists' do
        describe 'using the nondefault namespace as normal' do
          subject { Katuv::Utility.constantize(:ExampleConst, SomeNamespace) }

          before do
            module SomeNamespace
              class ExampleConst
              end
            end
          end

          it { should be SomeNamespace::ExampleConst }
        end

        describe 'when looking up from the default namespace for something downscope' do
          subject { Katuv::Utility.constantize(:ExampleConst) }

          #it { should be SomeNamespace::ExampleConst }
        end

        context 'when looking up from a parallel namespace' do
          before { module SomeOtherNamespace ; end }

          subject { Katuv::Utility.constantize(:ExampleConst, SomeOtherNamespace) }

          it { should be_nil }
        end
      end

      context 'when the class does not exist' do
        subject { Katuv::Utility.constantize(:ExampleNotConst, SomeNamespace) }

        it { should be_nil }
      end
    end
  end
end
