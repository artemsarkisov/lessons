module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, validation_type, *params)
      @validations ||= []
      @validations << { name: name, validation_type: validation_type, params: params }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        var_value = instance_variable_get("@#{validation[:name]}")
        send validation[:validation_type], var_value, validation[:params]
      end
    end

    def valid?
      validate!
    rescue
      false
    end

    def presence(value, *args)
      raise "Value can't be nil or empty" if value.nil?
    end

    def format(value, format)
      raise "Attribute doesn't match required format" unless value.to_s.match(format[0])
    end

    def type(value, klass)
      raise "Wrong class" unless value.is_a?(klass[0])
    end
  end
end


