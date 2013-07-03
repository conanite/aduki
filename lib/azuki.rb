require "azuki/version"

module Azuki
  def self.to_value klass, setter, value
    type = klass.azuki_type_for_attribute_name setter
    type ? type.new(value) : value
  end

  def self.apply_attributes object, attrs
    setters = { }
    klass = object.class

    attrs.each do |setter, value|
      if setter.match /\./
        first, rest = setter.split(/\./, 2)
        setters[first] ||= { }
        setters[first][rest] = value
      elsif setter.match /\[\d+\]/
        setters[setter] = value
      else
        object.send "#{setter}=", value
      end
    end

    setters.each do |setter, value|
      if setter.match /\[\d+\]/
        setter = setter.gsub /\[\d+\]/, ''
        array = object.send setter.to_sym
        if array == nil
          array = []
          object.send("#{setter}=", array)
        end
        array << to_value(klass, setter, value)
      else
        type = klass.azuki_type_for_attribute_name setter
        object.send "#{setter}=", to_value(klass, setter, value)
      end
    end
  end

  module ClassMethods
    @@types = { }

    def azuki types
      @@types[self] = types
    end

    def azuki_type_for_attribute_name name
      @@types[self][name.to_sym]
    end
  end

  module Initializer
    def initialize attrs
      Azuki.apply_attributes self, attrs
    end

    def self.included(base)
      base.extend Azuki::ClassMethods
    end
  end
end
