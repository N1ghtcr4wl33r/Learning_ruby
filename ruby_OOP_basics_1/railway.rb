class Station
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @train_list = []
    @train_type = []
  end

  def accept_train(train)
    @train_list.push(train)
    @train_type.push(train.type)
  end

  def depart_train(train)
    @train_list.delete(train)
  end

  def train_list
    @train_list.each do |train|
      puts "Поезд номер #{train.number} - '#{train.type.capitalize}' "
    end
  end

  def train_list_by_type
    @train_type.uniq.each do |type|
      puts "На станции #{station_name} поездов типа '#{type.capitalize}' - #{@train_type.count(type)}"
    end
  end
end

class Route
  attr_reader :all_stations
  def initialize(station_name_first, station_name_last)
    @all_stations = [station_name_first, station_name_last]
  end

  def add_station_name_middle(station)
    @all_stations.insert(-2, station)
  end

  def remove_station_name_middle(station)
    @all_stations.delete(station)
  end
end

class Train
  attr_reader :number, :type, :number_of_wagons, :current_speed
  attr_accessor :current_station

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @current_speed = 0
    @current_station = 0
  end

  def speed_up(number)
    @current_speed += number
  end

  def shut_down
    @current_speed = 0
  end

  def pin_wagons
    if current_speed == 0
      @number_of_wagons += 1
    else
      puts "Прицепка/отцепка вагонов может осуществляться только если поезд не движется."
    end
  end

  def unpin_wagons
    if number_of_wagons > 0
      if current_speed == 0
        @number_of_wagons -= 1
      else
        puts "Прицепка/отцепка вагонов может осуществляться только если поезд не движется."
      end
    else
      puts "Число вагонов поезда равно 0"
    end
  end

  def take_route(route)
    @route = route
    @current_station = route.all_stations.first

  end

  def index_station
    @route.all_stations.to_s[@current_station]
  end

  def index_station_prev
    index = @route.all_stations.find_index(@current_station)
    if index > 0
      @route.all_stations[index - 1]
    else
      puts "Эта станция первая в маршруте"
    end
  end

  def index_station_next
    index = @route.all_stations.find_index(@current_station)
    if index < @route.all_stations.length - 1
      @route.all_stations[index + 1]
    else
      puts "Эта станция последняя в маршруте"
    end
  end

  def station_move_next
    index = @route.all_stations.find_index(@current_station)
    if index < @route.all_stations.length - 1
      @route.all_stations[index + 1]
      @current_station = @route.all_stations[index + 1]
    else
      puts "Эта станция последняя в маршруте"
    end
  end

  def station_move_back
    index = @route.all_stations.find_index(@current_station)
    if index > 0
      @route.all_stations[index - 1]
      @current_station = @route.all_stations[index - 1]
    else
      puts "Эта станция первая в маршруте"
    end
  end
end

=begin Комментарий с кодом для проверки работоспопобности railway.rb
train = Train.new(765, "coach", 14)
train2 = Train.new(3325, "freight", 26)
train3 = Train.new(3872, "freight", 19)
train4 = Train.new(711, "coach", 24)

station = Station.new("Весенняя")
station2 = Station.new("Щербинка")

station.accept_train(train)
station.accept_train(train3)
station.accept_train(train2)
station.accept_train(train4)
station.train_list
station.train_list_by_type
station.depart_train(train4)

route = Route.new("Весенняя", "Щербинка")
route.add_station_name_middle("Кутузовская")
route.add_station_name_middle("Подольск")
route.add_station_name_middle("Силикатная")
route.add_station_name_middle("Гривно")
route.remove_station_name_middle("Гривно")
puts route.all_stations

train.speed_up 40
puts train.current_speed
train.shut_down
puts train.number_of_wagons
train.pin_wagons
train.unpin_wagons
train.take_route(route)
train.station_move_next
puts train.index_station_prev
puts train.index_station
puts train.index_station_next
=end
