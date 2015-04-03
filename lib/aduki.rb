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

  def self.maybe_parse_date str
    return nil if (str == nil) || (str == '')
    Date.parse(str)
  end

  def self.to_value klass, setter, value
    return value.map { |v| to_value klass, setter, v} if value.is_a? Array

    type = klass.aduki_type_for_attribute_name setter
    if type.is_a? Hash
      to_typed_hash type.values.first, value
    elsif type == Date
      case value
      when Date; value
      when String; maybe_parse_date(value)
      end
    elsif type == Time
      case value
      when Time; value
      when String; Time.parse(value)
      end
    elsif type && (type <= Integer)
      value.to_i
    elsif type && (type <= Float)
      value.to_f
    elsif type.respond_to? :aduki_find
      type.aduki_find value
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

  def self.apply_array_attribute klass, object, getter, value
    setter_method = "#{getter}=".to_sym
    return unless object.respond_to? setter_method

    array = object.send getter
    if array == nil
      array = []
      object.send(setter_method, array)
    end
    array << to_value(klass, getter, value)
  end

  def self.apply_single_attribute klass, object, setter, value
    setter_method = "#{setter}=".to_sym
    return unless object.respond_to? setter_method

    object.send setter_method, to_value(klass, setter, value)
  end

  def self.apply_attribute klass, object, setter, value
    if setter.match(/\[\d+\]/)
      getter = setter.gsub(/\[\d+\]/, '').to_sym
      apply_array_attribute klass, object, getter, value
    else
      apply_single_attribute klass, object, setter, value
    end
  end

  def self.apply_attributes object, attrs
    setters = split_attributes(attrs || { })
    klass = object.class

    setters.sort.each do |setter, value|
      apply_attribute klass, object, setter, value
    end
  end

  module ClassMethods
    @@types = { }

    def aduki types
      @@types[self] ||= { }
      @@types[self] = @@types[self].merge types
      types.each do |attr, k|
        attr = attr.to_sym
        attr_reader attr unless method_defined? attr
        attr_writer attr unless method_defined? :"#{attr}="
      end
    end

    def aduki_type_for_attribute_name name
      hsh = @@types[self]
      hsh ? hsh[name.to_sym] : nil
    end
  end

  module Initializer
    def initialize attrs={ }
      Aduki.apply_attributes self, attrs
    end

    def self.included(base)
      base.extend Aduki::ClassMethods
    end
  end
end
