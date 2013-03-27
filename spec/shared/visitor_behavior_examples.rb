shared_examples_for 'a visitable class' do
  it { should respond_to :each }
  it { should respond_to :method_name }
end

shared_examples_for 'a class with the visitable behavior' do
  let(:visitor) { double('visitor') }
  before { visitor.stub(:unknown) }

  context 'with before hook' do
    before { visitor.stub(:before) }

    it 'calls the before hook' do
      subject.visit(visitor)
      visitor.should have_received :before
    end

    context 'with after hook' do
      before { visitor.stub(:after) }

      it 'calls the after hook' do
        subject.visit(visitor)
        visitor.should have_received :after
      end

      context 'with class-dispatch method defined' do
        before { visitor.stub(subject.method_name.to_sym) }

        it 'calls the appropriate class method' do
          subject.visit(visitor)
          visitor.should have_received subject.method_name.to_sym
        end

        it "doesn't call the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should_not have_received :unknown
        end
      end

      context 'with no class-dispatch method defined' do
        before { visitor.stub(:unknown) }

        it "calls the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should have_received :unknown
        end

        it "doesn't call the class-dispatch method" do
          subject.visit(visitor)
          visitor.should_not have_received subject.method_name.to_sym
        end
      end
    end

    context 'without after hook' do
      it 'calls the after hook' do
        subject.visit(visitor)
        visitor.should_not have_received :after
      end

      context 'with class-dispatch method defined' do
        before { visitor.stub(subject.method_name.to_sym) }

        it 'calls the appropriate class method' do
          subject.visit(visitor)
          visitor.should have_received subject.method_name.to_sym
        end

        it "doesn't call the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should_not have_received :unknown
        end
      end

      context 'with no class-dispatch method defined' do
        it "calls the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should have_received :unknown
        end

        it "doesn't call the class-dispatch method" do
          subject.visit(visitor)
          visitor.should_not have_received subject.method_name.to_sym
        end
      end
    end
  end

  context 'without before hook' do
    it 'calls the before hook' do
      subject.visit(visitor)
      visitor.should_not have_received :before
    end

    context 'with after hook' do
      before { visitor.stub(:after) }

      it 'calls the after hook' do
        subject.visit(visitor)
        visitor.should have_received :after
      end

      context 'with class-dispatch method defined' do
        before { visitor.stub(subject.method_name.to_sym) }

        it 'calls the appropriate class method' do
          subject.visit(visitor)
          visitor.should have_received subject.method_name.to_sym
        end

        it "doesn't call the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should_not have_received :unknown
        end
      end

      context 'with no class-dispatch method defined' do

        it "calls the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should have_received :unknown
        end
        it "doesn't call the class-dispatch method" do
          subject.visit(visitor)
          visitor.should_not have_received subject.method_name.to_sym
        end

      end
    end

    context 'without after hook' do
      it 'does not call the after hook' do
        subject.visit(visitor)
        visitor.should_not have_received :after
      end

      context 'with class-dispatch method defined' do
        before { visitor.stub(subject.method_name.to_sym) }

        it 'calls the appropriate class method' do
          subject.visit(visitor)
          visitor.should have_received subject.method_name.to_sym
        end

        it "doesn't call the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should_not have_received :unknown
        end
      end

      context 'with no class-dispatch method defined' do

        it "calls the 'unknown' catchall method" do
          subject.visit(visitor)
          visitor.should have_received :unknown
        end

        it "doesn't call the class-dispatch method" do
          subject.visit(visitor)
          visitor.should_not have_received subject.method_name.to_sym
        end
      end
    end
  end
end
