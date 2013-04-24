module Katuv
  module DSL
    def nonterminal(type)
      raise NonterminalInTerminalError if terminal?
      define_method(_type_to_method_name(type)) do |name=nil, opts={}, &block|
        if children.has_key?(type) and children[type]
          children[type].run!(&block)
        else
          children[type] = type.new(name, opts.merge(parent: self), &block)
        end
        children[type]
      end
    end

    def terminal(type)
      #should only allow one.
      raise InvalidNodeTypeError unless type.terminal?
      define_method(_type_to_method_name(type)) do |name=nil, opts={}, &block|
        raise TerminalAlreadySetError if children.has_key?(type)
        children[type] = type.new(name, opts.merge(parent: self), &block)
      end
    end
    def terminal!
      define_singleton_method(:terminal?) { true }
    end
    def terminal?; false end

    def multiple(type)
      #should store an entry in #children that is a list of all the instances
      #it sees of this type. eg, `file 'x'; file 'y' #=> children[File] = [File<@name=x>, File<@name=y>]
      raise InvalidNodeTypeError unless type.terminal?
      define_method(_type_to_method_name(type)) do |name, opts={}, &block|
        children[type] ||= ObjectSet.new
        children[type] << type.new(name, opts.merge(parent: self), &block)
      end
    end

    def _type_to_method_name(type)
      if type.respond_to?(:name)
        type.name
      else
        type.to_s
      end.split('::').last.downcase
    end
  end

  class InvalidNodeTypeError < ArgumentError ; end
  class TerminalAlreadySetError < ArgumentError ; end
  class NonterminalInTerminalError < ArgumentError ; end
end
