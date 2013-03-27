shared_examples_for 'a nameable class' do
  its(:class) { should respond_to :name }
end

shared_examples_for 'a class with the naming behavior' do
  it { should respond_to :name }
  it { should respond_to :method_name }

  its(:method_name) { should_not =~ /[A-Z]/     } #no capitals
  its(:method_name) { should_not =~ /[\t\n\r ]/ } #no spaces
end
