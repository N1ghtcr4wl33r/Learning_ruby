require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  SAMPLER_TYPE = /^cargo$|^passenger$/.freeze
  SAMPLER_NUMBER = /^[a-zа-я\d]{3}-?[a-zа-я\d]{2}$/i.freeze

  attr_reader :number, :type, :route, :current_speed, :current_station

  @@trains = {}

  class << self
    def find(number)
      @@trains[number]
    end

    def print_wagons
      lambda do |wagon|
        free_places = wagon.free_places
        occupied_places = wagon.occupied_places
        puts "#{wagon.number}, #{wagon.type}, свободно #{free_places}, занято #{occupied_places}"
      end
    end
  end

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
    raise "Невозможно прицепить вагон с типом #{wagon.type} к поезду типа #{train.type}" unless type == wagon.type
    raise "Для прицепки вагона поезд должен находиться в неподвижном состоянии" unless current_speed.zero?

    wagon.number = wagon_count + 1
    wagons.push(wagon)
  end

  def unpin_wagon
    raise "Для удаления вагона необходимо, чтобы к поезду был прицеплен как минимум один вагон" unless wagon_count.positive?
    raise "Для отцепки вагона поезд должен находиться в неподвижном состоянии" unless current_speed.zero?

    wagons.pop
  end

  def take_route(route)
    self.route = route
    route.stations.first.accept_train(self)
    self.current_station = route.stations.first
  end

  def route_name
    raise "Маршрут не построен" if route.nil?

    "#{route.stations.first.name} - #{route.stations.last.name}"
  end

  def station_move_next
    return if index_station_next.nil?

    direction = index_station_next

    current_station.depart_train(self)
    self.current_station = direction
    current_station.accept_train(self)
  end

  def station_move_back
    return if index_station_prev.nil?

    direction = index_station_prev

    current_station.depart_train(self)
    self.current_station = direction
    current_station.accept_train(self)
  end

  def to_s
    "Номер поезда #{@number}, тип поезда #{@type}, число вагонов #{wagon_count}"
  end

  def each_wagon(&block)
    return unless block_given?

    wagons.each(&block)
  end

  def print_wagons_list
    each_wagon(&Train.print_wagons)
  end

  def wagon_select(number)
    wagons.find { |wagon| wagon.number == number }
  end

  protected

  # методы набора, сброса скорости, определения предыдущей, текущей, следующей стании, валидации вводимых данных могут быть доступны в подклассах

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
    raise "Эта станция первая в маршруте" unless index.positive?

    route.stations[index - 1]
  end

  def index_station_next
    index = route.stations.find_index(current_station)
    raise "Эта станция последняя в маршруте" unless index < route.stations.length - 1

    route.stations[index + 1]
  end

  def validate!
    errors = []
    errors << "Неправильный тип поезда. Используйте команды ':passenger' или ':cargo'" if @type !~ SAMPLER_TYPE
    errors << "Неправильный формат номера поезда. Используйте ***-** или *****" if @number !~ SAMPLER_NUMBER
    raise errors.join(".") unless errors.empty?
  end

  private

  # доступ к чтению аттрибутов вагона вне класса нежелателен

  attr_reader :wagons

  # доступ к изменению маршрута, текущей скорости, текущей станции вне класса нежелателен
  attr_writer :route, :current_speed, :current_station
end
