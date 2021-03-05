class Car
  attr_reader :id , :type
  attr_accessor :train
  include Manufacturer

  def initialize(id)
    @id = id
  end
end
