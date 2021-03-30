# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :attributes

    def validate(name, *args)
      @attributes ||= []
      @attributes << { name => args }
    end
  end

  module InstanceMethods
    def validate!
      self.class.attributes.each do |na|
        na.each do |name, args|
          attr = instance_variable_get("@#{name}")
          send "validate_#{args[0]}", attr, *args[1]
        end
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError
      false
    end

    private

    def validate_presence(attr)
      raise 'Значение атрибута nil или пустая строка' if attr.nil? || attr.empty?
    end

    def validate_format(attr, format)
      raise 'Значение атрибута не соответствует заданному формату' if attr !~ format
    end

    def validate_type(attr, type)
      raise 'Значение атрибута не соответствует заданному классу' unless attr.is_a? type
    end
  end
end
