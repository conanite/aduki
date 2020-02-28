require "aduki"
require "spec_helper"

describe Aduki::AttrFinder do
  it "assigns a value using attr_finder" do
    props = {
      "name"           => "Eamonn de Valera",
      "city_name"      => "dublin",
      "gift_names[0]"  => "dinner",
      "gift_names[1]"  => "whiskey",
      "gift_names[2]"  => "cigars",
      "spk_ohms[0]"    => 101,
      "spk_ohms[1]"    => 104,
      "spk_ohms[2]"    =>  98,
    }

    politician = Politician.new props

    expect(politician.name).to eq "Eamonn de Valera"
    expect(politician.city).to eq City::CITIES["dublin"]
    expect(politician.city.name).to eq "dublin"
    expect(politician.gifts).to eq [Gift.lookup("dinner"), Gift.lookup("whiskey"), Gift.lookup("cigars")]

    expect(politician.spks)                  .to be_a Array
    expect(politician.spks.map(&:class).uniq).to eq [Speaker]
    expect(politician.spks.map(&:ohms))      .to eq [101, 104, 98]
  end

  it "does not override a value with unknown identifier" do
    politician = Politician.new city: City.new(""), gifts: [Gift.new(name: "")]

    expect(politician.city.name).to eq ""
    expect(politician.gifts.map(&:name)).to eq [""]
  end

  it "converts atomic items to arrays when necessary" do
    g0 = Gift.lookup "whiskey"
    g1 = Gift.lookup "cigars"

    pol_0 = Politician.new gifts: [g0, g1]
    expect(pol_0.gifts).to eq [g0, g1]
    expect(pol_0.gift_names).to eq ["whiskey", "cigars"]

    pol_1 = Politician.new gift_names: ["whiskey", "cigars"]
    expect(pol_1.gifts).to eq [g0, g1]
    expect(pol_1.gift_names).to eq ["whiskey", "cigars"]

    pol_2 = Politician.new gift_names: "whiskey"
    expect(pol_2.gifts).to eq [g0]
    expect(pol_2.gift_names).to eq ["whiskey"]

    pol_3 = Politician.new gifts: g1
    expect(pol_3.gifts).to eq [g1]
    expect(pol_3.gift_names).to eq ["cigars"]
  end
end
