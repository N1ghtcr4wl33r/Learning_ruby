require_relative 'manufacturer'
require_relative 'validation'

class Wagon
  include Manufacturer
  include Validation

  SAMPLER_TYPE = /^cargo$|^passenger$/

  attr_reader :type
  attr_accessor :number

  def initialize(type, places)
    @type = type
    @places = places
    @occupied_places = 0

    validate!
  end

  def occupied_places
    @occupied_places
  end

  def free_places
    @places - @occupied_places
  end

  def to_s
    case type
      when :passenger
        "Номер вагона #{@number}, тип вагона #{@type}, количество свободных мест #{free_places}, количество занятых мест #{occupied_places}"
      when :cargo
        "Номер вагона #{@number}, тип вагона #{@type}, количество свободного объёма #{free_places}, количество занятого объёма #{occupied_places}"
    end
  end

  protected

  def validate!
    raise "Неправильный тип вагона" if @type !~ SAMPLER_TYPE
  end

end
