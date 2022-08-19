class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
end
