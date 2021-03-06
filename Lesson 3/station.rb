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
        puts "Поезд № #{train.number} с количеством вагонов: #{train.car_count}"
    end
  end

  def show_trains_with_type(type)
    index_type = 0
    puts"На станции #{name} находится всего #{trains.size} поезд(-ов, -а) из них #{type} типа:"
    trains.each do |train|
    if train.type == type
      index_type += 1
      puts "Поезд № #{train.number} с количеством вагонов: #{train.car_count}, тип: #{train.type}."
    end
    end
    puts "Всего поездов #{type} типа: #{index_type} "
  end

  def depart_train(train)
    trains.delete(train)
  end
end
