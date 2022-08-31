module Accessors
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        name_variable = "@#{name}".to_sym
        name_history_variable = "@#{name}_history".to_sym
        define_method(name) do
          instance_variable_get(name_variable)
        end

        define_method("#{name}_history") do
          instance_variable_get(name_history_variable)
        end

        define_method("#{name}=") do |value|
          instance_variable_set(name_variable, value)
          value_history = instance_variable_get(name_history_variable) || []
          instance_variable_set(name_history_variable, value_history << value)
        end
      end
    end
    
    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        unless value.is_a?(type)
          raise TypeError, "Несоответствие типу #{type}"
        end
        instance_variable_set(var_name, value)
      end
    end
  end
end