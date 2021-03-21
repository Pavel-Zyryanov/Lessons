class Station
  attr_reader :name, :trains

  include InstanceCounter
  @@stations = []
  include Valid

  NAME_FORMAT = /^[а-яa-z]+\s?[а-яa-z]*$/i

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def get_train(train)
    @trains << train
  end

  def show_trains
    puts "На станции #{name} находится #{trains.size} поезд(ов)"
    trains.each do |train|
      puts "Поезд № #{train.number}"
    end
  end

  def each_trains(&block)
    @trains.each(&block)
  end

  def show_trains_with_type(type)
    index_type = 0
    puts "На станции #{name} находится всего #{trains.size} поезд(-ов, -а) из них #{type} типа:"
    trains.each do |train|
      if train.type == type
        index_type += 1
        puts "Поезд № #{train.number}, тип: #{train.type}."
      end
    end
    puts "Всего поездов #{type} типа: #{index_type} "
  end

  def depart_train(train)
    trains.delete(train)
  end

  protected

  def validate!
    validate_station_name
    validate_station_exist
  end

  def validate_station_name
    raise 'Неверный формат названия станции' if @name !~ NAME_FORMAT
  end

  def validate_station_exist
    raise 'Станция с таким названием уже существует' if @@stations.map { |station| station.name }.include?(@name)
  end
end
