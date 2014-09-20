module Condicion
  def es_valida(block, instancia)
    instancia.instance_eval &block
  end
  # def aplicar(instancia)
end
class Validacion
  include Condicion

  def initialize condition
    @condition = condition
  end

  def aplicar(instancia)
    if (!es_valida(@condition, instancia))
      raise ValidationError
    end
  end
end

class ValidationError < StandardError; end