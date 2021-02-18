require './train'
require './route'
require './station'
station_chel = Station.new("Челябинск")
station_mia = Station.new("Миасс")
station_tur = Station.new("Тур")
station_zlat = Station.new("Златоуст")

route_chel_zlat = Route.new(station_chel, station_zlat)
route_chel_zlat.add_station(station_mia)
route_chel_zlat.add_station(station_tur)

route_chel_zlat.delete_station(station_tur)
route_chel_zlat.show_all_station

train1 = Train.new(1,"passenger", 16)
train2 = Train.new(2, "cargo", 30)

train1.set_route(route_chel_zlat)
train2.set_route(route_chel_zlat)
train1.go_forward
train1.go_forward
train2.go_forward
train2.go_forward
train2.go_back
train2.go_back

train1.add_car
train1.delete_car
train1.delete_car

station_chel.show_trains
station_zlat.show_trains

station_zlat.show_trains_with_type("cargo")
station_zlat.show_trains_with_type("passenger")

station_chel.show_trains_with_type("cargo")
station_chel.show_trains_with_type("passenger")
