require "aduki"
require "spec_helper"

describe Aduki::Initializer do

  it "should set a bunch of properties from a hash of property paths" do
    props = {
      "name"            => "Willy",
      "email"           => "willy@wonka.softify.com",
      "item"            => "HXB5H",
      "thing"           => "0",
      "gadget.name"     => "My Big Gadget",
      "gadget.price"    => "21",
      "gadget.supplier" => "Apple, Inc.",
      "machines[0].name" => "The First Machine",
      "machines[0].weight" => "88",
      "machines[0].speed" => "142",
      "machines[0].builder.name"   => "The First Machine Builder",
      "machines[0].builder.email"  => "wibble@bump",
      "machines[0].builder.phone"  => "4099",
      "machines[0].builder.office" => "2nd floor room 12",
      "machines[0].assemblies[0].name"   => "first machine, first assembly", # the array index distinguishes items but does not order them
      "machines[0].assemblies[1].name"   => "first machine, second assembly",
      "machines[0].assemblies[2].name"   => "first machine, third assembly",
      "machines[0].assemblies[0].colour" => "red",
      "machines[0].assemblies[1].colour" => "green",
      "machines[0].assemblies[2].colour" => "blue",
      "machines[0].assemblies[0].size"   => "pretty large",
      "machines[0].assemblies[1].size"   => "sort of medium",
      "machines[0].assemblies[2].size"   => "miniscule",
      "machines[0].dimensions[0]"   => "2346.56",
      "machines[0].dimensions[1]"   => "6456.64",
      "machines[0].dimensions[2]"   => "3859.39",
      "machines[0].dimensions[3]"   => "2365.68",
      "machines[0].team.lead"       => "Shakespeare", # there is no class definition for #team, so Aduki will apply a hash with properties #lead, #code, #design
      "machines[0].team.code"       => "Chaucer",
      "machines[0].team.design"     => "Jobs",
      "machines[0].helpers.jim.name"   => "Jim Appleby",
      "machines[0].helpers.jim.email"  => "Jim.Appleby@example.com",
      "machines[0].helpers.jim.phone"  => "123 456 789",
      "machines[0].helpers.jim.office" => "Elephant & Castle",
      "machines[0].helpers.ben.name"   => "Ben Barnes",
      "machines[0].helpers.ben.email"  => "Ben.Barnes@example.com",
      "machines[0].helpers.ben.phone"  => "123 456 790",
      "machines[0].helpers.ben.office" => "Cockney",
      "machines[0].helpers.pat.name"   => "Patrick O'Brien",
      "machines[0].helpers.pat.email"  => "Patrick.O.Brien@example.com",
      "machines[0].helpers.pat.phone"  => "123 456 791",
      "machines[0].helpers.pat.office" => "Hammersmith",
      "machines[1].name"           => "The Second Machine",
      "machines[1].weight"         => "34",
      "machines[1].speed"          => "289",
      "machines[1].builder.name"   => "The Second Machine Builder",
      "machines[1].builder.email"  => "waggie@bump",
      "machines[1].builder.phone"  => "4101",
      "machines[1].builder.office" => "3rd floor room 23",
      "machines[1].assemblies[98].name"   => "second machine, first assembly",  # the array index orders items but the position is not respected
      "machines[1].assemblies[98].colour" => "purple",
      "machines[1].assemblies[98].size"   => "pretty small",
      "machines[1].assemblies[1].name"   => "second machine, second assembly",
      "machines[1].assemblies[1].colour" => "turquoise",
      "machines[1].assemblies[1].size"   => "large-ish",
      "machines[1].assemblies[99].name"   => "second machine, third assembly",
      "machines[1].assemblies[99].colour" => "magenta",
      "machines[1].assemblies[99].size"   => "gigantic",
      "machines[1].dimensions[20]"   => "1985.85",
      "machines[1].dimensions[30]"   => "7234.92",
      "machines[1].dimensions[40]"   => "9725.52",
      "machines[1].dimensions[50]"   => "3579.79",
      "machines[1].team.lead"       => "Joyce",
      "machines[1].team.code"       => "O'Brien",
      "machines[1].team.design"     => "Moore",
      "machines[1].team.muffins"    => "MacNamara",
      "contraptions[0].x"          => "19",
      "contraptions[0].y"          => "0.003",
      "contraptions[1].x"          => "12",
      "contraptions[1].y"          => "0.0012",
      "contraptions[2].x"          => "24",
      "contraptions[2].y"          => "0.00063",
      "contraptions[3].x"          => "16",
      "contraptions[3].y"          => "0.00091",
      "countries[0]"               => "France",
      "countries[1]"               => "Sweden",
      "countries[2]"               => "Germany",
      "countries[3]"               => "Ireland",
      "countries[4]"               => "Spain",
    }

    model = Model.new props

    model.name.should == "Willy"
    model.email.should == "willy@wonka.softify.com"
    model.item.should == "HXB5H"
    model.thing.should == "0"
    model.gadget.name.should == "My Big Gadget"
    model.gadget.price.should == "21"
    model.gadget.supplier.should == "Apple, Inc."
    model.machines[0].name.should == "The First Machine"
    model.machines[0].weight.should == "88"
    model.machines[0].speed.should == "142"
    model.machines[0].builder.name.should == "The First Machine Builder"
    model.machines[0].builder.email.should == "wibble@bump"
    model.machines[0].builder.phone.should == "4099"
    model.machines[0].builder.office.should == "2nd floor room 12"
    model.machines[0].assemblies[0].name.should == "first machine, first assembly"
    model.machines[0].assemblies[0].colour.should == "red"
    model.machines[0].assemblies[0].size.should == "pretty large"
    model.machines[0].assemblies[1].name.should == "first machine, second assembly"
    model.machines[0].assemblies[1].colour.should == "green"
    model.machines[0].assemblies[1].size.should == "sort of medium"
    model.machines[0].assemblies[2].name.should == "first machine, third assembly"
    model.machines[0].assemblies[2].colour.should == "blue"
    model.machines[0].assemblies[2].size.should == "miniscule"
    model.machines[0].dimensions[0].should == "2346.56"
    model.machines[0].dimensions[1].should == "6456.64"
    model.machines[0].dimensions[2].should == "3859.39"
    model.machines[0].dimensions[3].should == "2365.68"
    model.machines[0].team.should == { "lead" => "Shakespeare", "code" => "Chaucer", "design" => "Jobs"}
    model.machines[0].helpers["jim"].should be_a MachineBuilder
    model.machines[0].helpers["jim"].name.should == "Jim Appleby"
    model.machines[0].helpers["jim"].email.should == "Jim.Appleby@example.com"
    model.machines[0].helpers["jim"].phone.should == "123 456 789"
    model.machines[0].helpers["jim"].office.should == "Elephant & Castle"
    model.machines[0].helpers["ben"].should be_a MachineBuilder
    model.machines[0].helpers["ben"].name.should == "Ben Barnes"
    model.machines[0].helpers["ben"].email.should == "Ben.Barnes@example.com"
    model.machines[0].helpers["ben"].phone.should == "123 456 790"
    model.machines[0].helpers["ben"].office.should == "Cockney"
    model.machines[0].helpers["pat"].should be_a MachineBuilder
    model.machines[0].helpers["pat"].name.should == "Patrick O'Brien"
    model.machines[0].helpers["pat"].email.should == "Patrick.O.Brien@example.com"
    model.machines[0].helpers["pat"].phone.should == "123 456 791"
    model.machines[0].helpers["pat"].office.should == "Hammersmith"
    model.machines[1].name.should == "The Second Machine"
    model.machines[1].weight.should == "34"
    model.machines[1].speed.should == "289"
    model.machines[1].builder.name.should == "The Second Machine Builder"
    model.machines[1].builder.email.should == "waggie@bump"
    model.machines[1].builder.phone.should == "4101"
    model.machines[1].builder.office.should == "3rd floor room 23"
    model.machines[1].assemblies[0].name.should == "second machine, second assembly"
    model.machines[1].assemblies[0].colour.should == "turquoise"
    model.machines[1].assemblies[0].size.should == "large-ish"
    model.machines[1].assemblies[1].name.should == "second machine, first assembly"
    model.machines[1].assemblies[1].colour.should == "purple"
    model.machines[1].assemblies[1].size.should == "pretty small"
    model.machines[1].assemblies[2].name.should == "second machine, third assembly"
    model.machines[1].assemblies[2].colour.should == "magenta"
    model.machines[1].assemblies[2].size.should == "gigantic"
    model.machines[1].dimensions[0].should == "1985.85"
    model.machines[1].dimensions[1].should == "7234.92"
    model.machines[1].dimensions[2].should == "9725.52"
    model.machines[1].dimensions[3].should == "3579.79"
    model.machines[1].team.should == { "lead" => "Joyce", "code" => "O'Brien", "design" => "Moore", "muffins" => "MacNamara"}
    model.contraptions[0].x.should == "19"
    model.contraptions[0].y.should == "0.003"
    model.contraptions[1].x.should == "12"
    model.contraptions[1].y.should == "0.0012"
    model.contraptions[2].x.should == "24"
    model.contraptions[2].y.should == "0.00063"
    model.contraptions[3].x.should == "16"
    model.contraptions[3].y.should == "0.00091"
    model.countries[0].should == "France"
    model.countries[1].should == "Sweden"
    model.countries[2].should == "Germany"
    model.countries[3].should == "Ireland"
    model.countries[4].should == "Spain"

    sensibly_indexed_props = props.merge({
      "machines[1].assemblies[0].name"   => "second machine, second assembly",
      "machines[1].assemblies[0].colour" => "turquoise",
      "machines[1].assemblies[0].size"   => "large-ish",
      "machines[1].assemblies[1].name"   => "second machine, first assembly",
      "machines[1].assemblies[1].colour" => "purple",
      "machines[1].assemblies[1].size"   => "pretty small",
      "machines[1].assemblies[2].name"   => "second machine, third assembly",
      "machines[1].assemblies[2].colour" => "magenta",
      "machines[1].assemblies[2].size"   => "gigantic",
      "machines[1].dimensions[0]"   => "1985.85",
      "machines[1].dimensions[1]"   => "7234.92",
      "machines[1].dimensions[2]"   => "9725.52",
      "machines[1].dimensions[3]"   => "3579.79",
    })

    silly_keys = [ "machines[1].assemblies[98].name",
                   "machines[1].assemblies[98].colour",
                   "machines[1].assemblies[98].size",
                   "machines[1].assemblies[99].name",
                   "machines[1].assemblies[99].colour",
                   "machines[1].assemblies[99].size",
                   "machines[1].dimensions[20]",
                   "machines[1].dimensions[30]",
                   "machines[1].dimensions[40]",
                   "machines[1].dimensions[50]"]

    silly_keys.each { |k| sensibly_indexed_props.delete k }

    Aduki.to_aduki(model).should == sensibly_indexed_props
  end
end
