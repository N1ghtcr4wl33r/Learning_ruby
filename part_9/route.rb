require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :station_first, :station_last

  def initialize(station_first, station_last)
    @stations = [station_first, station_last]
    register_instance
  end

  def add_station_middle(station)
    @stations.insert(-2, station) unless stations.include?(station)
  end

  def remove_station_middle(station)
    @stations.delete(station)
  end

  def station_list
    stations[1..-2]
  end

  def to_s
    name_list = stations.map(&:name)
    name_list.join(' - ')
  end

  private

  # доступ к изменению промежуточных станций вне класса нежелателен

  attr_writer :stations
end
