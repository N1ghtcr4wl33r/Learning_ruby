require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  SAMPLER_NAME = /^[a-zа-я\d\s]{2,15}$/i

  @@stations = []

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def accept_train(train)
    trains.push(train)
  end

  def depart_train(train)
    trains.delete(train)
  end

  def trains_type(type)
    trains.select { |train| train.type.downcase == type.downcase }
  end

  class << self
    def all
      @@stations
    end
  end

  protected
  def validate!
    raise "Название станции введено неверно. Используйте буквы, цифры и пробел, длина названия может быть от 2 до 15 символов" if @name !~ SAMPLER_NAME
  end
end
