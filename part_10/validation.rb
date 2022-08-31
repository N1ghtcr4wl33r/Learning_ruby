module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, type, *args)
      @validate ||= []
      @validate << {name: name, type: type, args: args}
    end
  end

  module InstanceMethods
    def validate!
      expr = if self.class.superclass == Object
            self.class.instance_variable_get(:@validate)
            else
            self.class.superclass.instance_variable_get(:@validate)
            end
      expr.each do |hash|
        name = hash[:name]
        value = instance_variable_get("@#{name}".to_sym)
        type = hash[:type]
        args = hash[:args].first
        send("validate_#{type}".to_sym, name, value, args)
      end
    end

    def validate_presence(name, value, argt)
      raise "Значение #{name} не установлено" if value.nil? || value.to_s.empty?
    end

    def validate_format(name, value, regexp)
      raise "Значение #{name} должна совпадать с #{regexp}" if value !~ regexp
    end

    def validate_type(name, value, type)
      raise "Тип #{name} должен быть типом #{type}" unless value.is_a?(type)
    end
  end
end
