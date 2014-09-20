require_relative 'validacion'

class ConditionalMethod
  include Condicion
  def initialize name, condition, block
    @name = name
    @condition = condition
    @block = block
  end

  def aplicar instancia
    if (es_valida(@condition, instancia))
      instancia.define_singleton_method @name, @block
    end
  end
end