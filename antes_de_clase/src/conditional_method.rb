
class ConditionalMethod
  def initialize name, condition, block
    @name = name
    @condition = condition
    @block = block
  end

  def definir_si_aplica(instance)
    if (instance.instance_eval &@condition)
      instance.define_singleton_method @name, @block
    end
  end
end
