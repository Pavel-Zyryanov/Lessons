# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, options = {})
      define_method(:validate!) do
        attr = instance_variable_get("@#{name}".to_sym)
        raise 'Значение атрибута nil или пустая строка' if options[:presence] && attr.nil? || attr == ''
        if options[:format] && attr.to_s !~ options[:format]
          raise 'Значение атрибута не соответствует заданному формату'
        end
        raise 'Значение атрибута не соответствует заданному классу' if options[:type] && !attr.is_a?(options[:type])

        true
      end
    end
  end

  module InstanceMethods
    define_method(:valid?) do
      begin
        validate!
      rescue StandardError
        false
      end
    end
  end
end
