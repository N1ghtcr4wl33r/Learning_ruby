require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Railroad
  attr_reader :routes, :trains, :stations

  def initialize
    @routes = {}
    @trains = {}
    @stations = {}
  end

  def intro
    puts "Эта программа позволяет управлять виртуальной железной дорогой."
    puts "Введите 1, чтобы выполнить предварительные команды (сиды)"
    choice = gets.chomp.to_i
    puts
    seed if choice == 1
  end

  def menu
    puts "Введите одну из команд, указанных ниже, для продолжения:"
    puts "Введите 1, чтобы создать станцию"
    puts "Введите 2, чтобы создать поезд"
    puts "Введите 3, чтобы создать маршрут"
    puts "Введите 4, чтобы добавить станцию в маршрут"
    puts "Введите 5, чтобы удалить станцию в маршруте"
    puts "Введите 6, чтобы назначить маршрут поезду"
    puts "Введите 7, чтобы добавить вагон к поезду"
    puts "Введите 8, чтобы отцепить вагон от поезда"
    puts "Введите 9, чтобы переместить поезд по маршруту вперед на одну станцию"
    puts "Введите 10, чтобы переместить поезд по маршруту назад на одну станцию"
    puts "Введите 11, чтобы просмотреть список станций"
    puts "Введите 12, чтобы просмотреть список поездов на станции"
    puts "Введите 0, чтобы выйти из программы."
  end

  def begin(input)
    case input
      when "1"
        station_new
      when "2"
        train_new
      when "3"
        route_new
      when "4"
        add_station
      when "5"
        remove_station
      when "6"
        take_route_train
      when "7"
        pin_wagon_train
      when "8"
        unpin_wagon_train
      when "9"
        station_next
      when "10"
        station_prev
      when "11"
        stations_list
      when "12"
        train_list
      when "0"
        exit
      else
        puts "Команда введена неправильно!"
    end
  end

  def seed
    trains["П-765"] = PassengerTrain.new("П-765")
    trains["Г-3325"] = CargoTrain.new("Г-3325")
    trains["Г-3872"] = CargoTrain.new("Г-3872")
    trains["П-711"] = PassengerTrain.new("П-711")

    stations["Весенняя"] = Station.new("Весенняя")
    stations["Щербинка"] = Station.new("Щербинка")
    stations["Чехов"] = Station.new("Чехов")
    stations["Кутузовская"] = Station.new("Кутузовская")
    stations["Подольск"] = Station.new("Подольск")
    stations["Силикатная"] = Station.new("Силикатная")
    stations["Чепелёво"] = Station.new("Чепелёво")
    stations["Пл. 66 км"] = Station.new("Пл. 66 км")
    stations["Столбовая"] = Station.new("Столбовая")
    stations["Молоди"] = Station.new("Молоди")
    stations["Львовская"] = Station.new("Львовская")
    stations["Гривно"] = Station.new("Гривно")

    routes["Весенняя - Щербинка"] = Route.new(stations["Весенняя"], stations["Щербинка"])
    routes["Чехов - Весенняя"] = Route.new(stations["Чехов"], stations["Весенняя"])
    routes["Весенняя - Щербинка"].add_station_middle(stations["Кутузовская"])
    routes["Весенняя - Щербинка"].add_station_middle(stations["Подольск"])
    routes["Весенняя - Щербинка"].add_station_middle(stations["Силикатная"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Чепелёво"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Пл. 66 км"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Столбовая"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Молоди"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Львовская"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Гривно"])

    trains["П-765"].pin_wagon(PassengerWagon.new)
    trains["П-765"].pin_wagon(PassengerWagon.new)
    trains["П-765"].pin_wagon(PassengerWagon.new)
    trains["П-765"].pin_wagon(PassengerWagon.new)
    trains["Г-3325"].pin_wagon(CargoWagon.new)
    trains["Г-3325"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["Г-3872"].pin_wagon(CargoWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)
    trains["П-711"].pin_wagon(PassengerWagon.new)

    trains["П-765"].take_route(routes["Весенняя - Щербинка"])
    trains["Г-3325"].take_route(routes["Весенняя - Щербинка"])
    trains["Г-3872"].take_route(routes["Чехов - Весенняя"])
    trains["П-711"].take_route(routes["Чехов - Весенняя"])

    trains["П-765"].station_move_next
    trains["Г-3325"].station_move_next
    trains["Г-3325"].station_move_next
    trains["Г-3325"].station_move_next
    trains["Г-3872"].station_move_next
    trains["Г-3872"].station_move_next

  end

  def station_new
    puts "Введите название станции:"
    name = gets.capitalize.chomp
    if stations[name].nil?
      stations[name] = Station.new(name)
      puts "Добавлена станция '#{name}'"
    else
      puts "Станция '#{name}' уже существует"
    end
  end


  def train_new
    puts "Введите '1', если хотите добавить пассажирский поезд; введите '2', если хотите добавить грузовой поезд:"
    input = gets.chomp.to_i
    case input
    when 1
      type = :passenger
      prefix = "П-"
    when 2
      type = :cargo
      prefix = "Г-"
    else
      puts "Тип поезда указан неправильно"
    end

    puts "Введите номер поезда:"
    print prefix
    number = gets.chomp
    puts

    case type
    when :passenger
      number = "П-" + number
      trains[number] = PassengerTrain.new(number)
      puts "Добавлен поезд '#{number}'"
    when :cargo
      number = "Г-" + number
      trains[number] = CargoTrain.new(number)
      puts "Добавлен поезд '#{number}'"
    end
  end

  def route_new
    station_first = select_station("Выбор начальной станции")
    return break_input if station_first.nil?

    available_stations = stations_name_list - [station_first.name]

    station_last = select_station("Выбор конечной станции", available_stations)
    return break_input if station_last.nil?

    route_name = "#{station_first.name} - #{station_last.name}"
    routes[route_name] = Route.new(station_first, station_last)
    puts "Добавлен маршрут '#{route_name}'"
  end

  def add_station
    route = route_input
    return break_input if route.nil?

    exception = route.stations.map {|station| station.name}
    available_stations = stations_name_list - exception
    station = select_station("Выбор промежуточной станции", available_stations)
    return break_input if station.nil?

    route.add_station_middle(station)
    puts "Станция '#{station.name}' добавлена. Текущий маршрут: " + route.to_s
  end

  def remove_station
    route = route_input
    return break_input if route.nil?

    exception = route.station_list.map {|station| station.name}
    available_stations = exception
    station = select_station("Выбор промежуточной станции", available_stations)
    return break_input if station.nil?

    route.remove_station_middle(station)
    puts "Станция '#{station.name}' удалена. Текущий маршрут: " + route.to_s
  end

  def take_route_train
    train = train_input
    return break_input if train.nil?

    route = route_input
    return break_input if route.nil?

    train.take_route(route)

    puts "Для поезда номер '#{train.number}' присвоен маршрут '#{train.route_name}'"
  end

  def pin_wagon_train
    train = train_input
    return break_input if train.nil?

    case train.type
    when :passenger
      train.pin_wagon(PassengerWagon.new)
    when :cargo
      train.pin_wagon(CargoWagon.new)
    end

    puts "Вагон добавлен к поезду с номером '#{train.number}'"

  end

  def unpin_wagon_train
    train = train_input
    return break_input if train.nil?

    train.unpin_wagon

  end

  def station_next
    train = train_input
    return break_input if train.nil?

    station = train.current_station
    train.station_move_next
    current_station = train.current_station

    if station != current_station
      puts "Поезд номер '#{train.number}' перемещен на станцию '#{current_station.name}'"
      puts "Эта станция последняя в маршруте" if train.current_station == train.route.station_last
    else
      puts "Поезд номер '#{train.number}' находится на станции ''#{station.name}', станция конечная"
    end
  end

  def station_prev
    train = train_input
    return break_input if train.nil?

    station = train.current_station
    train.station_move_back
    current_station = train.current_station

    if station != current_station
      puts "Поезд номер '#{train.number}' перемещен на станцию '#{current_station.name}'"
      puts "Эта станция первая в маршруте" if train.current_station == train.route.station_first
    else
      puts "Поезд номер '#{train.number}' находится на станции '#{station.name}', эта станция первая в маршруте"
    end
  end

  def stations_list
    if stations_name_list.empty?
      puts "Не было добавлено ни одной станции"
    else
      puts "Список станций:"
      puts stations_name_list.join(", ")
    end
      puts
  end

  def train_list
    station = select_station
    return break_input if station.nil?

    passenger_trains = station.trains_type(:passenger)
    cargo_trains = station.trains_type(:cargo)

    if (passenger_trains.empty? && cargo_trains.empty?)
      puts "На данной станции нет поездов"
      return
    end

    if !cargo_trains.empty?
      puts "Поезда типа 'грузовой' на станции:"

      cargo_trains.each do |train|
        puts "Номер поезда: #{train.number}, число вагонов: #{train.wagon_count}, " +
          "основной маршрут: #{train.route_name}"
      end
    end

    if !passenger_trains.empty?
      puts "Поезда типа 'пассажирский' на станции:"
      passenger_trains.each do |train|
        puts "Номер поезда: #{train.number}, число вагонов: #{train.wagon_count}, " +
          "основной маршрут: #{train.route_name}"
      end
    end
  end

  #внутренние методы, необходимые для работы класса Railroad
  private

  def stations_name_list
    stations.keys
  end

  def routes_name_list
    routes.keys
  end

  def trains_number_list
    trains.keys
  end

  def select_station(prefix = "", available_stations = stations_name_list)
    if stations_name_list.empty?
      puts "Не было добавлено ни одной станции"
      puts

      return
    end

    if available_stations.empty?
      puts "Нет станций, которые можно выбрать"
      puts

      return
    end

    puts "#{prefix} " if prefix != ""
    puts "Введите название станции"
    puts "Доступные станции: " + available_stations.join(", ")
    puts "Для отмены введите '0'"
    print "- "

    input = select_list(available_stations)

    if input.nil?
      puts "Не выбрано не одной станции"
      puts

      return
    end

    station = stations[input]

    if station.nil?
      puts "Станция #{input} не обнаружена"
    end

    station
  end

  def select_list(list)
    return if list.length.zero?

    loop do
      input = gets.chomp
      puts

      break if input == "0"

      if list.include?(input)
        return input
      else
        puts "Введите значение из списка: " + list.join(", ")
        puts "Для отмены введите '0'"
        print "- "
      end
    end
  end

  def route_input
    if routes_name_list.empty?
      puts "Список маршрутов пуст"

      return
    end

    puts "Введите маршрут:"
    puts "Список маршрутов: " + routes_name_list.join(", ")
    puts "Для отмены введите команду: '0'"
    print "- "

    route_name = select_list(routes_name_list)

    if route_name.nil?
      puts "Отмена выбора маршрута"
      puts

      return
    end

    route = routes[route_name]

    if route.nil?
      puts "Маршрут '#{route_name}' не найден"
    end

    route
  end

  def train_input
    if trains_number_list.empty?
      puts "Список поездов пуст"

      return
    end

    puts "Введите номер поезда:"
    puts "Список доступных номеров поездов: " + trains_number_list.join(", ")
    puts "Для отмены введите команду: '0'"
    puts "- "

    number = select_list(trains_number_list)

    if number.nil?
      puts "Отмена выбора поезда"
      puts

      return
    end

    train = trains[number]

    if train.nil?
      puts "Поезд с номером '#{number}' не найден"
      puts
    end

    train
  end

  def break_input
    puts "Остановка выполнения команды"
    puts
  end
end

railroad = Railroad.new

railroad.intro
loop do
  railroad.menu
  input = gets.chomp
  railroad.begin(input)
end
