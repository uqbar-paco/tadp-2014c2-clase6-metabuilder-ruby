
class Builder
  def initialize a_class, setters, validaciones, conditional_methods
    # solo puede construir clases con constructores sin parámetros
    if (a_class.instance_method(:initialize).arity != 0)
      raise InvalidConstructorError
    end

    @instance = a_class.new
    @setters = setters
    @validaciones = validaciones
    @conditional_methods = conditional_methods
  end

  def build
    validar
    aplicar_metodos
    @instance
  end

  def validar
    invalido = @validaciones.any? { |validacion|
      !@instance.instance_eval &validacion
    }
    if (invalido)
      raise ValidationError
    end
  end

  def method_missing name, *args, &block
    if (@setters.include? name)
      @instance.send(name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(name, include_private = false)
    @setters.include? name || super
  end
  
  def aplicar_metodos
    @conditional_methods.each { |conditional_method| conditional_method.definir_si_aplica(@instance) }
  end
end

class ValidationError < StandardError; end
class InvalidConstructorError < StandardError; end
