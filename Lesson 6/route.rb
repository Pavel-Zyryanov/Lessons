class Route
  attr_reader :stations
  include InstanceCounter
  include Valid
  @@routes = []

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    validate!
    @@routes << self
    register_instance
  end

  def name
    @name = stations.first.name + ' - ' + stations.last.name
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Нельзя удалять первую и последнюю станцию маршрута."
    else
      stations.delete(station)
    end
  end

  def show_all_station
    stations.each do |station|
      puts station.name
      end
  end

  protected

  def validate!
    validate_route_exist
  end

  def validate_route_exist
    raise 'Такой маршрут уже существует' if @@routes.map { |route| route.stations }.include?(@stations)
  end

end
