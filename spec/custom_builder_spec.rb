require "aduki"
require "spec_helper"

describe Aduki::Initializer do

  it "should assign a value using a custom finder" do
    props = {
      "name"   => "Anna Livia",
      "city"   => "dublin"
    }

    contraption = MachineBuilder.new props

    expect(contraption.name).to eq "Anna Livia"
    expect(contraption.city).to eq CITIES["dublin"]
    expect(contraption.city.name).to eq "Dublin"
  end
end
