require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

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
    puts "Введите 13, чтобы просмотреть список поездов всех станций"
    puts "Введите 14, чтобы просмотреть список вагонов поезда"
    puts "Введите 15, чтобы занять место или объем в вагоне поезда"
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
    when "13"
      full_list
    when "14"
      wagon_list
    when "15"
      fill_wagon
    when "0"
      exit
    else
      raise ArgumentError, "Команда введена неправильно. Используйте номер команды от 0 до 15"
    end
  rescue ArgumentError => e
    p "Ошибка: #{e.message}"
  end

  def seed
    trains["П76-65"] = PassengerTrain.new("П76-65")
    trains["Г3325"] = CargoTrain.new("Г3325")
    trains["Г38-72"] = CargoTrain.new("Г38-72")
    trains["П7114"] = PassengerTrain.new("П7114")

    stations["Весенняя"] = Station.new("Весенняя")
    stations["Щербинка"] = Station.new("Щербинка")
    stations["Чехов"] = Station.new("Чехов")
    stations["Кутузовская"] = Station.new("Кутузовская")
    stations["Подольск"] = Station.new("Подольск")
    stations["Силикатная"] = Station.new("Силикатная")
    stations["Чепелево"] = Station.new("Чепелево")
    stations["Пл 66 км"] = Station.new("Пл 66 км")
    stations["Столбовая"] = Station.new("Столбовая")
    stations["Молоди"] = Station.new("Молоди")
    stations["Львовская"] = Station.new("Львовская")
    stations["Гривно"] = Station.new("Гривно")

    routes["Весенняя - Щербинка"] = Route.new(stations["Весенняя"], stations["Щербинка"])
    routes["Чехов - Весенняя"] = Route.new(stations["Чехов"], stations["Весенняя"])
    routes["Весенняя - Щербинка"].add_station_middle(stations["Кутузовская"])
    routes["Весенняя - Щербинка"].add_station_middle(stations["Подольск"])
    routes["Весенняя - Щербинка"].add_station_middle(stations["Силикатная"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Чепелево"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Пл 66 км"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Столбовая"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Молоди"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Львовская"])
    routes["Чехов - Весенняя"].add_station_middle(stations["Гривно"])

    trains["П76-65"].pin_wagon(PassengerWagon.new(46))
    trains["П76-65"].pin_wagon(PassengerWagon.new(72))
    trains["П76-65"].pin_wagon(PassengerWagon.new(60))
    trains["П76-65"].pin_wagon(PassengerWagon.new(54))
    trains["Г3325"].pin_wagon(CargoWagon.new(84))
    trains["Г3325"].pin_wagon(CargoWagon.new(140))
    trains["Г38-72"].pin_wagon(CargoWagon.new(90))
    trains["Г38-72"].pin_wagon(CargoWagon.new(150))
    trains["Г38-72"].pin_wagon(CargoWagon.new(80))
    trains["Г38-72"].pin_wagon(CargoWagon.new(100))
    trains["Г38-72"].pin_wagon(CargoWagon.new(115))
    trains["Г38-72"].pin_wagon(CargoWagon.new(130))
    trains["Г38-72"].pin_wagon(CargoWagon.new(94))
    trains["П7114"].pin_wagon(PassengerWagon.new(75))
    trains["П7114"].pin_wagon(PassengerWagon.new(45))
    trains["П7114"].pin_wagon(PassengerWagon.new(40))
    trains["П7114"].pin_wagon(PassengerWagon.new(65))
    trains["П7114"].pin_wagon(PassengerWagon.new(58))
    trains["П7114"].pin_wagon(PassengerWagon.new(72))
    trains["П7114"].pin_wagon(PassengerWagon.new(80))
    trains["П7114"].pin_wagon(PassengerWagon.new(48))
    trains["П7114"].pin_wagon(PassengerWagon.new(66))
    trains["П7114"].pin_wagon(PassengerWagon.new(74))

    trains["П76-65"].take_route(routes["Весенняя - Щербинка"])
    trains["Г3325"].take_route(routes["Весенняя - Щербинка"])
    trains["Г38-72"].take_route(routes["Чехов - Весенняя"])
    trains["П7114"].take_route(routes["Чехов - Весенняя"])

    trains["П76-65"].station_move_next
    trains["Г3325"].station_move_next
    trains["Г3325"].station_move_next
    trains["Г3325"].station_move_next
    trains["Г38-72"].station_move_next
    trains["Г38-72"].station_move_next
  end

  def station_new
    puts "Введите название станции (используйте буквы, цифры и пробел, длина названия может быть от 2 до 15 символов):"
    name = gets.capitalize.chomp
    raise StandardError, "Станция '#{name}' уже существует" unless stations[name].nil?

    stations[name] = Station.new(name)
    p name
    puts
  rescue StandardError => e
    p "Ошибка: #{e.message}"
    retry
  end

  def train_new
    p "Введите '1', если хотите добавить пассажирский поезд; введите '2', если хотите добавить грузовой поезд:"
    input = gets.chomp.to_i
    case input
    when 1
      type = :passenger
    when 2
      type = :cargo
    else
      raise ArgumentError, "Тип поезда указан неправильно. Используйте цифры 1-2"
    end
    p "Введите номер поезда (используйте следующий формат номера: ***-** или *****):"
    number = gets.chomp
    case type
    when :passenger
      trains[number] = PassengerTrain.new(number)
      p "Добавлен пассажирский поезд '#{number}'"
      puts
    when :cargo
      trains[number] = CargoTrain.new(number)
      p "Добавлен грузовой поезд '#{number}'"
      puts
    end
  rescue StandardError => e
    p "Ошибка: #{e.message}"
    retry
  end

  def route_new
    station_first = select_station("Выбор начальной станции")
    return break_input if station_first.nil?

    available_stations = stations_name_list - [station_first.name]

    station_last = select_station("Выбор конечной станции", available_stations)
    return break_input if station_last.nil?

    route_name = "#{station_first.name} - #{station_last.name}"
    routes[route_name] = Route.new(station_first, station_last)
    p route_name
  end

  def add_station
    route = route_input
    return break_input if route.nil?

    exception = route.stations.map(&:name)
    available_stations = stations_name_list - exception
    station = select_station("Выбор промежуточной станции", available_stations)
    return break_input if station.nil?

    route.add_station_middle(station)
    p route.to_s
  end

  def remove_station
    route = route_input
    return break_input if route.nil?

    exception = route.station_list.map(&:name)
    available_stations = exception
    station = select_station("Выбор промежуточной станции", available_stations)
    return break_input if station.nil?

    route.remove_station_middle(station)
    p route.to_s
  end

  def take_route_train
    train = train_input
    return break_input if train.nil?

    route = route_input
    return break_input if route.nil?

    train.take_route(route)

    p "#{train.number} => #{train.route_name}"
  end

  def pin_wagon_train
    train = train_input
    return break_input if train.nil?

    case train.type
    when :passenger
      p "Введите количество мест в пассажирском вагоне. Допустимое значение 40-80"
      input = gets.chomp.to_i
      raise ArgumentError, "Введено неправильное значение количества мест. Используйте числа от 40 до 80" unless input >= 40 && input <= 80

      train.pin_wagon(PassengerWagon.new(input))
      p "Пассажирский вагон прицеплен к поезду с номером '#{train.number}'. Число мест - #{input}"
    when :cargo
      p "Введите вместимость грузового вагона. Допустимое значение 80-150 куб.м."
      input = gets.chomp.to_i
      unless input >= 80 && input <= 150
        raise ArgumentError, "Введено неправильное значение вместимости грузового вагона. Используйте числа от 80 до 150"; end

      train.pin_wagon(CargoWagon.new(input))
      p "Грузовой вагон вместимостью #{input} куб. м. прицеплен к поезду с номером '#{train.number}'"
    end
  rescue ArgumentError => e
    p "Ошибка: #{e.message}"
    retry
  end

  def unpin_wagon_train
    train = train_input
    return break_input if train.nil?

    train.unpin_wagon

    p "Вагон отцеплен от поезда с номером '#{train.number}'"
  rescue StandardError => e
    p "Ошибка: #{e.message}"
    retry
  end

  def station_next
    train = train_input
    return break_input if train.nil?

    station = train.current_station
    train.station_move_next
    current_station = train.current_station

    if station == current_station
      p "Поезд номер '#{train.number}' находится на станции ''#{station.name}', станция конечная"
    else
      p "Поезд номер '#{train.number}' перемещен на станцию '#{current_station.name}'"
      p "Эта станция последняя в маршруте" if train.current_station == train.route.station_last
    end
  rescue RuntimeError => e
    p "Ошибка: #{e.message}"
    retry
  rescue NoMethodError => e
    p "Ошибка: Поезду '#{train.number}' не был присвоен маршрут"
    retry
  end

  def station_prev
    train = train_input
    return break_input if train.nil?

    station = train.current_station
    train.station_move_back
    current_station = train.current_station

    if station == current_station
      p "Поезд номер '#{train.number}' находится на станции '#{station.name}', эта станция первая в маршруте"
    else
      p "Поезд номер '#{train.number}' перемещен на станцию '#{current_station.name}'"
      p "Эта станция первая в маршруте" if train.current_station == train.route.station_first
    end
  rescue RuntimeError => e
    p "Ошибка: #{e.message}"
    retry
  rescue NoMethodError => e
    p "Ошибка: Поезду '#{train.number}' не был присвоен маршрут"
    retry
  end

  def stations_list
    if stations_name_list.empty?
      p "Не было добавлено ни одной станции"
    else
      p "Список станций: "
      puts stations_name_list.join(", ")
      puts
    end
  end

  def train_list
    station = select_station
    return break_input if station.nil?

    passenger_trains = station.trains_type(:passenger)
    cargo_trains = station.trains_type(:cargo)

    if passenger_trains.empty? && cargo_trains.empty?
      p "На данной станции нет поездов"
      return
    end

    unless cargo_trains.empty?
      p "Поезда типа 'грузовой' на станции:"

      cargo_trains.each do |train|
        p "Номер поезда: #{train.number}, число вагонов: #{train.wagon_count}, " \
          "основной маршрут: #{train.route_name}"
      end
    end

    return if passenger_trains.empty?

    p "Поезда типа 'пассажирский' на станции:"
    passenger_trains.each do |train|
      p "Номер поезда: #{train.number}, число вагонов: #{train.wagon_count}, " \
        "основной маршрут: #{train.route_name}"
    end
  end

  def full_list
    stations.each_value do |station|
      p "Станция #{station.name}"
      puts

      station.each_train do |train|
        print " "
        Station.print_trains.call(train)
        puts

        train.each_wagon do |wagon|
          print " "
          Train.print_wagons.call(wagon)
        end

        puts
      end

      puts "-"
    end

    puts
  end

  def wagon_list
    train = train_input
    return break_input if train.nil?

    if train.wagon_count.zero?
      puts "К поезду не было добавлено ни одного вагона"
      puts
    else
      puts "Список вагонов поезда #{train.number}:"
      train.print_wagons_list
    end
  end

  def fill_wagon
    train = train_input
    return break_input if train.nil?

    train_wagons = []

    train.each_wagon { |wagon| train_wagons << wagon.number.to_s }

    p "Введите номер вагона"
    p "Список вагонов поезда #{train.number} : " + train_wagons.join(", ")
    print "- "

    train_wagon = select_list(train_wagons).to_i

    wagon = train.wagon_select(train_wagon)

    case wagon.type
    when :passenger
      if wagon.free_places.zero?
        p "В данном вагоне все места заняты"

        return
      end

      begin
        p "Введите число мест, которые необходимо занять. В данном вагоне свободно #{wagon.free_places} мест"

        input = gets.chomp.to_i
        if input <= wagon.free_places
          input.times { wagon.take_place }
        else
          p "Недостаточно свободных мест для выполнения операции"
          return
        end
      rescue RuntimeError => e
        p "Ошибка: #{e.message}"

        retry
      else
        p "В вагоне #{wagon.number} поезда #{train.number} занято #{input} мест"
      end
    when :cargo
      if wagon.free_places.zero?
        p "Весь объем этого вагона занят"

        return
      end

      begin
        p "Введите число куб.м., которые необходимо занять. В данном вагоне свободно #{wagon.free_places} куб.м."

        volume = gets.chomp.to_i

        wagon.fill_place(volume)
      rescue RuntimeError => e
        p "Ошибка: #{e.message}"

        retry
      else
        p "В вагоне #{wagon.number} поезда #{train.number} занято #{volume} куб.м."
      end

    end
  end

  # внутренние методы, необходимые для работы класса Railroad
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
    puts "Доступные станции: #{available_stations.join(', ')}"
    puts "Для отмены введите '0'"
    print "- "

    input = select_list(available_stations)

    if input.nil?
      puts "Не выбрано не одной станции"
      puts

      return
    end

    station = stations[input]

    puts "Станция #{input} не обнаружена" if station.nil?

    station
  end

  def select_list(list)
    return if list.length.zero?

    loop do
      input = gets.chomp
      puts

      break if input == "0"

      return input if list.include?(input)

      puts "Введите значение из списка: #{list.join(', ')}"
      puts "Для отмены введите '0'"
      print '- '
    end
  end

  def route_input
    if routes_name_list.empty?
      puts 'Список маршрутов пуст'

      return
    end

    puts 'Введите маршрут:'
    puts "Список маршрутов: #{routes_name_list.join(', ')}"
    puts "Для отмены введите команду: '0'"
    print '- '

    route_name = select_list(routes_name_list)

    if route_name.nil?
      puts "Отмена выбора маршрута"
      puts

      return
    end

    route = routes[route_name]

    puts "Маршрут '#{route_name}' не найден" if route.nil?

    route
  end

  def train_input
    if trains_number_list.empty?
      puts "Список поездов пуст"

      return
    end

    puts "Введите номер поезда:"
    puts "Список доступных номеров поездов: #{trains_number_list.join(', ')}"
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
