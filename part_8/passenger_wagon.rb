require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(places)
    super(:passenger, places)
  end

  def take_place!
    @occupied_places += 1
  end

  def take_place
    return take_place! if free_places > 0

    raise "Недостаточно свободных мест для выполнения операции. В данном вагоне все места заняты"
  end

end
