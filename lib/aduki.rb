require "date"
require "time"
require "aduki/version"

module Aduki
  def self.to_aduki obj, collector={ }, key="", join=""
    case obj
    when Hash
      obj.keys.inject(collector) { |result, k|
        v = obj[k]
        to_aduki v, collector, "#{key}#{join}#{k}", "."
        result
      }
    when Array
      obj.each_with_index do |av, ix|
        to_aduki av, collector, "#{key}[#{ix}]", "."
      end
    when String, Numeric, Symbol
      collector[key] = obj
    else
      vv = obj.instance_variables
      vv.each do |v|
        accessor = v.to_s.gsub(/^@/, "").to_sym
        if obj.respond_to?(accessor) && obj.respond_to?("#{accessor}=".to_sym)
          to_aduki obj.send(accessor), collector, "#{key}#{join}#{accessor}", "."
        end
      end
    end
    collector
  end

  def self.to_value klass, setter, value
    type = klass.aduki_type_for_attribute_name setter
    if type.is_a? Hash
      to_typed_hash type.values.first, value
    elsif type == Date
      Date.parse value
    elsif type == Time
      Time.parse value
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

    setters.sort.each do |setter, value|
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
