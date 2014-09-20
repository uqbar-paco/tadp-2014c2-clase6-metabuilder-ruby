require_relative 'builder'
require_relative 'conditional_method'
require_relative 'validacion'

class Metabuilder

  def self.config &block
    metabuilder = Metabuilder.new
    metabuilder.instance_eval &block
    metabuilder
  end

  def initialize
    @properties = []
    @acciones = []
  end

  def conditional_method name, condition, block
    @acciones <<
        ConditionalMethod.new(name, condition, block)
  end

  def set_target_class a_class
    @a_class = a_class
    self
  end

  def add_property a_property
    @properties << a_property
    self
  end

  def build
    Builder.new @a_class, @properties, @acciones
  end

  alias :property :add_property
  alias :target_class :set_target_class

  def validate &block
    @acciones << Validacion.new(block)
  end

end