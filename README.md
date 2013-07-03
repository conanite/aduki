# Azuki

Azuki is an attribute setter inspired only a little bit by the "Bean" concept in Java. Here's the idea:

    props = {
      "name" => "Wilbur",
      "size" => "3",
      "gadgets[0].id"         => "FHB5S",
      "gadgets[0].position.x" => "0.45",
      "gadgets[0].position.y" => "0.97",
      "gadgets[1].id"         => "SVE21",
      "gadgets[1].position.x" => "0.31",
      "gadgets[1].position.y" => "0.34",
    }

    model = Model.new props

At this point, #model is an instance of Model with its #name, and #size properties initialized as you would expect, and its #gadgets is an array of length 2, with each object initialized as you would expect.


## Installation

Add this line to your application's Gemfile:

    gem 'azuki'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install azuki

## Usage

For a complete example, please see the spec. It's a single file.

Here's an abbreviated version:

    class Assembly
      include Azuki::Initializer
      attr_accessor :name, :colour, :size
    end

    class Machine
      include Azuki::Initializer
      attr_accessor :name, :weight, :speed, :builder, :team
      attr_accessor :assemblies, :dimensions
      azuki :assemblies => Assembly, :builder => MachineBuilder
    end

    class Model
      include Azuki::Initializer

      attr_accessor :name, :email, :item, :thing, :gadget
      attr_accessor :machines, :contraptions, :countries
      azuki :gadget => Gadget, :machines => Machine, :contraptions => Contraption
    end


Azuki::Initializer adds an #initialize instance method that knows how to read a hash of properties and apply them, much like ActiveRecord::Base,
with one major difference: Azuki splits property names on "." and applies the hash recursively. Azuki also pays special attention to "[]" in property
names, initializing an array of items instead of an item directly. Azuki uses the array index inside "[]" to distinguish elements, but not to order them.


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
