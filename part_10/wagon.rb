require_relative 'manufacturer'
require_relative 'validation'
require_relative 'accessors'

class Wagon
  include Manufacturer
  include Validation
  include Accessors

  SAMPLER_TYPE = /^cargo$|^passenger$/.freeze

  attr_reader :type, :occupied_places
  attr_accessor :number
  strong_attr_accessor :places, Integer

  validate :type, :format, SAMPLER_TYPE

  def initialize(type, places)
    @type = type
    @places = places
    @occupied_places = 0

    validate!
  end

  def free_places
    @places - @occupied_places
  end

  def to_s
    case type
    when :passenger
      "Номер вагона #{@number}, тип вагона #{@type}, количество свободных
      мест #{free_places}, количество занятых мест #{occupied_places}"
    when :cargo
      "Номер вагона #{@number}, тип вагона #{@type}, количество свободного
      объёма #{free_places}, количество занятого объёма #{occupied_places}"
    end
  end
end
