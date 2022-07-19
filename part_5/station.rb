class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    @train_type = []
  end

  def accept_train(train)
    trains.push(train)
    @train_type.push(train.type)
  end

  def depart_train(train)
    trains.delete(train)
  end

  def train_list
    @train_type.uniq.each do |type|
      puts "На станции #{name} поездов типа '#{type.capitalize}' - #{@train_type.count(type)}"
    end
  end

  def trains_type(type)
    trains.select { |train| train.type.downcase == type.downcase }
  end
end
