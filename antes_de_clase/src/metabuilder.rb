require_relative 'builder'
require_relative 'conditional_method'

class Metabuilder
  attr_accessor :a_target_class, :setters, :validaciones, :conditional_methods

  def initialize
    self.setters = []
    self.validaciones = []
    self.conditional_methods = []
  end

  def set_target_class a_target_class
    self.a_target_class = a_target_class
    self
  end

  def add_property name
    self.setters << name.to_s.concat('=').to_sym
    self
  end

  def validate &block
    validaciones << block
  end

  def conditional_method name, condition, block
    conditional_methods << ConditionalMethod.new(name, condition, block)
  end

  def build
    Builder.new a_target_class, setters, validaciones, conditional_methods
  end

  alias :target_class :set_target_class
  alias :property :add_property

  def self.config &block
    metabuilder = Metabuilder.new
    metabuilder.instance_eval &block
    metabuilder
  end
end
