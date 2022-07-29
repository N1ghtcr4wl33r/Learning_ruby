require_relative 'instance_counter'
require_relative 'manufacturer'

class Train
  include Manufacturer
  include InstanceCounter

  attr_reader :number, :type, :route, :current_speed, :current_station

  @@trains = {}

  def initialize(number)
    @number = number
    @wagons = []
    @current_speed = 0
    @@trains[number] = self
    register_instance
  end

  def wagon_count
    wagons.length
  end

  def pin_wagon(wagon)
    wagons.push(wagon) if (current_speed == 0) && (wagon.type == type)
  end

  def unpin_wagon
    if (current_speed == 0) && (wagon_count > 0)
      wagons.pop
      puts "Вагон отцеплен от поезда с номером '#{number}'"
    else
      puts "Для удаления вагона необходимо, чтобы к поезду был прицеплен как минимум один вагон"
    end
  end

  def take_route(route)
    self.route = route
    route.stations.first.accept_train(self)
    self.current_station = route.stations.first

  end

  def route_name
    if !route.nil?
      "#{route.stations.first.name} - #{route.stations.last.name}"
    else
      "Маршрут не построен"
    end
  end

  def station_move_next
    if index_station_next.nil?
      return
    end

    direction = index_station_next

    current_station.depart_train(self)
    self.current_station = direction
    current_station.accept_train(self)
  end

  def station_move_back
    if index_station_prev.nil?
      return
    end

    direction = index_station_prev

    current_station.depart_train(self)
    self.current_station = direction
    current_station.accept_train(self)
  end

  protected

  #методы набора и сброса скорости, определения предыдущей, текущей и следующей стании могут быть доступны только в подклассах

  def speed_up(number)
    @current_speed += number
  end

  def shut_down
    @current_speed = 0
  end

  def index_station
    route.stations.to_s[current_station]
  end

  def index_station_prev
    index = route.stations.find_index(current_station)
    if index > 0
      route.stations[index - 1]
    else
      puts "Эта станция первая в маршруте"
    end
  end

  def index_station_next
    index = route.stations.find_index(current_station)
    if index < route.stations.length - 1
      route.stations[index + 1]
    else
      puts "Эта станция последняя в маршруте"
    end
  end

  class << self
    def find(number)
      @@trains[number]
    end
  end

  private

  #доступ к чтению аттрибутов вагона вне класса нежелателен

  attr_reader :wagons

  #доступ к изменению маршрута, текущей скорости, текущей станции вне класса нежелателен

  attr_writer :route, :current_speed, :current_station

end
