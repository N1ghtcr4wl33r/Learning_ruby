require_relative 'train'
class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    super(number)
    @type = :cargo
  end

end
