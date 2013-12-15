require "aduki/version"

module Aduki
  def self.to_aduki hsh
    hsh.keys.inject({ }) { |result, k|
      result[k] = hsh[k]
      result
    }
  end

  def self.to_value klass, setter, value
    type = klass.aduki_type_for_attribute_name setter
    if type.is_a? Hash
      to_typed_hash type.values.first, value
    else
      type ? type.new(value) : value
    end
  end

  def self.to_typed_hash klass, value
    setters = split_attributes value
    hsh = { }
    setters.each { |k, v|
      hsh[k] = klass.new(v)
    }
    hsh
  end

  def self.split_attributes attrs
    setters = { }
    attrs.each do |setter, value|
      if setter.match(/\./)
        first, rest = setter.split(/\./, 2)
        setters[first] ||= { }
        setters[first][rest] = value
      else
        setters[setter] = value
      end
    end
    setters
  end

  def self.apply_attributes object, attrs
    setters = split_attributes attrs
    klass = object.class

    setters.each do |setter, value|
      if setter.match(/\[\d+\]/)
        setter = setter.gsub(/\[\d+\]/, '')
        array = object.send setter.to_sym
        if array == nil
          array = []
          object.send("#{setter}=", array)
        end
        array << to_value(klass, setter, value)
      else
        object.send "#{setter}=", to_value(klass, setter, value)
      end
    end
  end

  module ClassMethods
    @@types = { }

    def aduki types
      @@types[self] ||= { }
      @@types[self] = @@types[self].merge types
    end

    def aduki_type_for_attribute_name name
      hsh = @@types[self]
      hsh ? hsh[name.to_sym] : nil
    end
  end

  module Initializer
    def initialize attrs
      Aduki.apply_attributes self, attrs
    end

    def self.included(base)
      base.extend Aduki::ClassMethods
    end
  end
end
