require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :number, :type, :route, :current_speed, :current_station

  SAMPLER_TYPE = /^cargo$|^passenger$/
  SAMPLER_NUMBER = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i

  @@trains = {}

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @wagons = []
    @current_speed = 0
    @@trains[number] = self
    register_instance
  end

  def wagon_count
    wagons.length
  end

  def pin_wagon(wagon)
    if self.type == wagon.type
      if current_speed == 0
        wagons.push(wagon)
      else
        raise "Для прицепки вагона поезд должен находиться в неподвижном состоянии"
      end
    else
      raise "Невозможно прицепить вагон с типом #{wagon.type} к поезду типа #{self.type}"
    end
  end

  def unpin_wagon
    if wagon_count > 0
      if current_speed == 0
        wagons.pop
      else
        raise "Для отцепки вагона поезд должен находиться в неподвижном состоянии"
      end
    else
      raise "Для удаления вагона необходимо, чтобы к поезду был прицеплен как минимум один вагон"
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
      raise "Маршрут не построен"
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

   class << self
    def find(number)
      @@trains[number]
    end
  end

  protected

  #методы набора и сброса скорости, определения предыдущей, текущей и следующей стании, валидации вводимых данных могут быть доступны только в подклассах

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
      raise "Эта станция первая в маршруте"
      return
    end
  end

  def index_station_next
    index = route.stations.find_index(current_station)
    if index < route.stations.length - 1
      route.stations[index + 1]
    else
      raise "Эта станция последняя в маршруте"
      return
    end
  end

  def validate!
    errors = []
    errors << "Неправильный тип поезда. Используйте команды ':passenger' или ':cargo'" if @type !~ SAMPLER_TYPE
    errors << "Неправильный формат номера поезда. Используйте ***-** или *****" if @number !~ SAMPLER_NUMBER
  raise errors.join(".") unless errors.empty?
  end

  private

  #доступ к чтению аттрибутов вагона вне класса нежелателен

  attr_reader :wagons

  #доступ к изменению маршрута, текущей скорости, текущей станции вне класса нежелателен

  attr_writer :route, :current_speed, :current_station

end
