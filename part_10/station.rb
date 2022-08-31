require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  include InstanceCounter
  include Validation
  include Accessors

  SAMPLER_NAME = /^[a-zа-я\d\s]{2,15}$/i.freeze

  attr_accessor_with_history :name, :trains

  validate :name, :format, SAMPLER_NAME

  @@stations = []

  class << self
    attr_reader :all

    def print_trains
      ->(train) { puts "#{train.number}, #{train.type}, #{train.wagon_count}" }
    end
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    validate!
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
end
