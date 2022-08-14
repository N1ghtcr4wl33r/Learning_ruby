require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(places)
    super(:cargo, places)
  end

  def fill_place!(volume)
    @occupied_places += volume
  end

  def fill_place(volume)
    return fill_place!(volume) if free_places >= volume

    raise "Недостаточно свободного объёма для заполнения вагона. Используйте меньшее значение"
  end
end

