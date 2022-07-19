require_relative 'train'
class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = :cargo
  end

  def add_wagon(wagon)
    if wagon.type == type
      super
      puts "Вагон прицеплен"
    else
      puts "Неподходящий тип вагона! Прицепить такой тип вагона невозможно"
    end
  end

end
