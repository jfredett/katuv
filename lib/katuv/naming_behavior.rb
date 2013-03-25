module Katuv
  module NamingBehavior
    def name
      @name ||= self.class.name
    end

    #this is terrible
    def method_name
      #get the classname
      self.class.name.to_s.
        #remove the module
        split('::').last.
        #convert FooBar -> _Foo_Bar
        gsub(/[A-Z]/, '_\&').
        #drop the leading _
        sub(/^_/, '').
        #downcase everything to get foo_bar
        downcase.to_sym
    end

  end
end
