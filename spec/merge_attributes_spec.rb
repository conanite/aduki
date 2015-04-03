require "aduki"
require "spec_helper"

describe Aduki::Initializer do
  it "should initialize attributes of pre-initialized nested objects" do
    props = {
      "name"                => "Brackish Water",
      "gadget.name"         => "The Loud Gadget",
      "gadget.speaker.ohms" => "29"
    }

    model = Model.new props

    expect(model.name).                   to eq "Brackish Water"
    expect(model.gadget.name).            to eq "The Loud Gadget"
    expect(model.gadget.price).           to eq nil
    expect(model.gadget.speaker.ohms).    to eq "29"
    expect(model.gadget.speaker.diameter).to eq nil

    more_props = {
      "name"                    => "Smelly Brackish Water",
      "gadget.price"            => "42",
      "gadget.speaker.diameter" => "large"
    }

    Aduki.apply_attributes model, more_props

    expect(model.name).                   to eq "Smelly Brackish Water"
    expect(model.gadget.name).            to eq "The Loud Gadget"
    expect(model.gadget.price).           to eq "42"
    expect(model.gadget.speaker.ohms).    to eq "29"
    expect(model.gadget.speaker.diameter).to eq "large"
  end

  it "does not die when reader accessor is absent" do
    props = {
      "name"                => "Brackish Water",
      "gadget.wattage"      => "240",
      "gadget.name"         => "The Loud Gadget",
      "gadget.speaker.ohms" => "29"
    }

    model = Model.new props

    expect(model.name).                   to eq "Brackish Water"
    expect(model.gadget.name).            to eq "The Loud Gadget"
    expect(model.gadget.price).           to eq nil
    expect(model.gadget.watts).           to eq "240"
    expect(model.gadget.speaker.ohms).    to eq "29"
    expect(model.gadget.speaker.diameter).to eq nil
  end

  it "does not die when an existing value is present" do
    props = {
      "name"                => "Brackish Water",
      "gadget.wattage"      => "240",
      "gadget.name"         => "The Loud Gadget",
      "gadget.speaker.ohms" => "29"
    }

    model = Model.new props

    more_props = {
      "name"                    => "Smelly Brackish Water",
      "gadget.wattage"          => "120",
      "gadget.speaker.diameter" => "large"
    }

    Aduki.apply_attributes model, more_props

    expect(model.name).                   to eq "Smelly Brackish Water"
    expect(model.gadget.name).            to eq "The Loud Gadget"
    expect(model.gadget.price).           to eq nil
    expect(model.gadget.watts).           to eq "120"
    expect(model.gadget.speaker.ohms).    to eq "29"
    expect(model.gadget.speaker.diameter).to eq "large"
  end
end
