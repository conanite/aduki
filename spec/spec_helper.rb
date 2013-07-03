
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.order = 'random'
end

class Contraption
  include Aduki::Initializer
  attr_accessor :x, :y
end

class Assembly
  include Aduki::Initializer
  attr_accessor :name, :colour, :size
end

class MachineBuilder
  include Aduki::Initializer
  attr_accessor :name, :email, :phone, :office
end

class Gadget
  include Aduki::Initializer
  attr_accessor :name, :price, :supplier
end

class Machine
  include Aduki::Initializer
  attr_accessor :name, :weight, :speed, :builder, :team
  attr_accessor :assemblies, :dimensions
  aduki :assemblies => Assembly, :builder => MachineBuilder
end

class Model
  include Aduki::Initializer

  attr_accessor :name, :email, :item, :thing, :gadget
  attr_accessor :machines, :contraptions, :countries
  aduki :gadget => Gadget
  aduki :machines => Machine
  aduki :contraptions => Contraption
end

