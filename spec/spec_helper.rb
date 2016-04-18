
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.order = 'random'
end


class City < Struct.new(:name)
  CITIES = { }
  def self.aduki_find value
    CITIES[value]
  end

  def register
    CITIES[name] = self
  end
end

City.new("paris").register
City.new("madrid").register
City.new("stockholm").register
City.new("dublin").register

class Contraption
  include Aduki::Initializer
  attr_accessor :x, :y, :planned, :updated
  aduki :planned => Date, :updated => Time
end

class Assembly
  include Aduki::Initializer
  attr_writer :weight
  attr_accessor :name, :colour, :size, :height
  aduki :height => Integer, :weight => Float
end

class MachineBuilder
  include Aduki::Initializer
  attr_accessor :name, :email, :phone, :office, :city
  aduki :city => City
end

class Speaker
  include Aduki::Initializer
  attr_accessor :ohms, :diameter, :dimensions
  aduki threads: Float
  aduki_initialize :dates, Array, Date
  aduki_initialize :dimensions, Array, nil
  aduki_initialize :threads, Array, nil
end

class Gadget
  include Aduki::Initializer
  attr_accessor :name, :price, :supplier, :variables
  attr_writer :wattage
  aduki_initialize :speaker, Speaker
  aduki_initialize :variables, Aduki::RecursiveHash, nil

  def watts
    @wattage
  end
end

class Machine
  include Aduki::Initializer
  attr_reader :builder
  attr_accessor :name, :weight, :speed, :team
  attr_accessor :dimensions
  aduki :assemblies => Assembly, :builder => MachineBuilder
  aduki :helpers => { :key => MachineBuilder }
end

class Model
  include Aduki::Initializer

  attr_accessor :name, :email, :item, :thing, :gadget
  attr_accessor :machines, :contraptions, :countries
  aduki :gadget => Gadget
  aduki :machines => Machine
  aduki :contraptions => Contraption
end
