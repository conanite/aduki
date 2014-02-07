require "aduki"
require "spec_helper"

describe Aduki::Initializer do

  it "should assign a Date attribute" do
    props = {
      "x" => "The X",
      "y" => "The Y",
      "planned" => "1945-01-19",
    }

    contraption = Contraption.new props

    expect(contraption.planned).to be_a Date
    expect(contraption.planned.year).to eq 1945
    expect(contraption.planned.month).to eq 1
    expect(contraption.planned.day).to eq 19
  end
end
