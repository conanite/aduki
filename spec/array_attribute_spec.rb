require "aduki"
require "spec_helper"

describe Aduki::Initializer do

  it "should assign an integer attribute" do
    props = {
      "name"         => "Foo",
      "assemblies"   => [{ "name" => "A0", "height" => "10" }, { "name" => "A1", "height" => "20" }, { "name" => "A2", "height" => "30" }, ]
    }

    machine = Machine.new props

    expect(machine.name).to eq "Foo"

    expect(machine.assemblies[0].name).to eq "A0"
    expect(machine.assemblies[0].height).to eq 10

    expect(machine.assemblies[1].name).to eq "A1"
    expect(machine.assemblies[1].height).to eq 20

    expect(machine.assemblies[2].name).to eq "A2"
    expect(machine.assemblies[2].height).to eq 30
  end
end
