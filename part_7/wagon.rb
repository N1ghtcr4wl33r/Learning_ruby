require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include Manufacturer
  include Validation

  SAMPLER_TYPE = /^cargo$|^passenger$/

  attr_reader :type

  def initialize(type)
    @type = type
    validate!
  end

  protected

  def validate!
    raise "Неправильный тип вагона" if @type !~ SAMPLER_TYPE
  end

end
