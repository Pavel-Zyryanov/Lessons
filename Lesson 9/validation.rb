# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :attributes

    def validate(name, type, *args)
      @attributes ||= []
      @attributes << { name: name, type: type, options: args }
    end
  end

  module InstanceMethods
    def validate!
      attributes = self.class.attributes
      attributes.each do  |attribute|
        attribute_value = instance_variable_get("@#{attribute[:name]}")
        send(attribute[:type], attribute[:name], attribute_value, attribute[:options])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def presence(_name, attribute_value, _args = nil)
      raise 'Значение атрибута nil или пустая строка' if attribute_value.nil? || attribute_value.empty?
    end

    def format(_name, attribute_value, format)
      raise 'Значение атрибута не соответствует заданному формату' if attribute_value !~ format[0]
    end

    def type(_name, attribute_value, type)
      raise 'Значение атрибута не соответствует заданному классу' unless attribute_value != type[0]
    end
  end
end
