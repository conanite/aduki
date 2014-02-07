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

  it "should assign a Time attribute" do
    props = {
      "x" => "The X",
      "y" => "The Y",
      "updated" => "1945-01-19 15:43",
    }

    contraption = Contraption.new props

    expect(contraption.updated).to be_a Time
    puts contraption.updated.inspect
    expect(contraption.updated.year).to eq 1945
    expect(contraption.updated.month).to eq 1
    expect(contraption.updated.day).to eq 19
    expect(contraption.updated.hour).to eq 15
    expect(contraption.updated.min).to eq 43
    expect(contraption.updated.sec).to eq 0
  end
end
