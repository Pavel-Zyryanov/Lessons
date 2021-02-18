class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def get_train(train)
    trains << train
  end

  def show_trains
    puts "На станции #{name} находится #{trains.size} поезд(ов)"
    trains.each do |train|
        puts train
    end
  end

  def show_trains_with_type(type)
    trains.select { |train| train.type == type }
    puts "На станции #{name} находится #{trains.size} поезд(ов) #{type} типа"
  end

  def depart_train(train)
    trains.delete(train)
  end
end
