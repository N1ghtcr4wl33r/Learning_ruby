require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @@stations = []

  def initialize(name)
    @name = name
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
end
