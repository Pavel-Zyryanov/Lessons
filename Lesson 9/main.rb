# frozen_string_literal: true

require_relative 'menu'
require_relative 'manufacturer'
require_relative 'accessors'
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'

test = Menu.new
test.start_menu
