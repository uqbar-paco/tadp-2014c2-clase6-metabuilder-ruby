class Builder
  def initialize a_class, properties, acciones
    @a_class = a_class
    @properties = {}
    properties.each { |property|
      setter = property.to_s.concat("=").to_sym
      @properties[setter] = nil
    }
    @acciones = acciones
  end

  def method_missing name, *args, &block
    if (@properties.has_key?(name))
      @properties[name] = args[0]
    else
      super
    end
  end

  def respond_to_missing? name, include_private = false
    @properties.has_key?(name) || super
  end

  def build
    instancia = @a_class.new
    @properties.each_pair {
      |key, value|
      instancia.send(key, value)
    }

    @acciones.each { |accion|
      accion.aplicar(instancia)
    }

    instancia
  end
end
