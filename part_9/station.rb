require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  SAMPLER_NAME = /^[a-zа-я\d\s]{2,15}$/i.freeze

  attr_reader :name, :trains

  @@stations = []

  class << self
    attr_reader :all

    def print_trains
      ->(train) { puts "#{train.number}, #{train.type}, #{train.wagon_count}" }
    end
  end

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

  def each_train(&block)
    return unless block_given?

    trains.each { |train| block.call(train) }
  end

  def print_trains_list
    each_train(&Station.print_trains)
  end

  protected

  def validate!
    return unless @name !~ SAMPLER_NAME

    raise 'Неправильное название станции. Используйте буквы, цифры и пробел, название может быть от 2 до 15 символов'
  end
end
