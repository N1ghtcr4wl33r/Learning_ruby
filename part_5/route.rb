class Route
  attr_reader :stations, :station_name_first, :station_name_last
  def initialize(station_name_first, station_name_last)
    @station_name_first = station_name_first
    @station_name_last = station_name_last
    @stations = []

  end

  def add_station_name_middle(station)
    @stations.insert(-1, station) unless stations.include?(station)
  end

  def remove_station_name_middle(station)
    @stations.delete(station)
  end

  def station_list
    [station_name_first] + stations + [station_name_last]
  end

  def to_s
    name_list = station_list.map { |station| station.name }
    name_list.join(" - ")
  end

  private

  #доступ к изменению промежуточных станций вне класса нежелателен

  attr_writer :stations

end
