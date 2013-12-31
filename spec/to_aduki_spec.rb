require "aduki"
require "spec_helper"

describe Aduki do
  it "should return a plain hash structure" do
    hsh = { "foo" => "bar" }
    props = Aduki.to_aduki hsh
    props.should == { "foo" => "bar" }
  end

  it "should flatten nested keys" do
    hsh = { "foo" => "bar", "bing" => { "boo" => "wogga", "tingle" => "wimp" } }
    props = Aduki.to_aduki hsh
    props.should == {
      "foo"         => "bar",
      "bing.boo"    => "wogga",
      "bing.tingle" => "wimp"
    }
  end

  it "should flatten deeply nested keys" do
    hsh = {
      "foo" => "bar",
      "bing" => {
        "boo" => "wogga",
        "tingle" => "wimp",
        "harpoon" => {
          "shonk" => "twaddle",
          "scorn" => "shart"
        }} }
    props = Aduki.to_aduki hsh
    props.should == {
      "foo"         => "bar",
      "bing.boo"    => "wogga",
      "bing.tingle" => "wimp",
      "bing.harpoon.shonk" => "twaddle",
      "bing.harpoon.scorn" => "shart",
    }
  end

  it "should flatten array keys also " do
    hsh = {
      "foo" => "bar",
      "bing" => {
        "boo" => "wogga",
        "tingle" => "wimp",
        "harpoon" => ["shonk",
                      "twaddle",
                      "scorn",
                      "shart" ]
      } }
    props = Aduki.to_aduki hsh
    props.should == {
      "foo"         => "bar",
      "bing.boo"    => "wogga",
      "bing.tingle" => "wimp",
      "bing.harpoon[0]" => "shonk",
      "bing.harpoon[1]" => "twaddle",
      "bing.harpoon[2]" => "scorn",
      "bing.harpoon[3]" => "shart",
    }
  end

  it "should flatten nested arrays " do
    hsh = {
      "foo" => "bar",
      "bing" => {
        "boo" => "wogga",
        "tingle" => "wimp",
        "harpoon" => ["shonk",
                      "twaddle",
                      %w{alpha beta gamma},
                      { :wing => :tip, :tail => :fin } ]
      } }
    props = Aduki.to_aduki hsh
    props.should == {
      "foo"         => "bar",
      "bing.boo"    => "wogga",
      "bing.tingle" => "wimp",
      "bing.harpoon[0]" => "shonk",
      "bing.harpoon[1]" => "twaddle",
      "bing.harpoon[2][0]" => "alpha",
      "bing.harpoon[2][1]" => "beta",
      "bing.harpoon[2][2]" => "gamma",
      "bing.harpoon[3].wing" => :tip,
      "bing.harpoon[3].tail" => :fin,
    }
  end

  it "should flatten aduki objects " do
    hsh = {
      "foo" => "bar",
      "bing" => {
        "boo" => "wogga",
        "tingle" => "wimp",
        "harpoon" => ["shonk",
                      "twaddle",
                      %w{alpha beta gamma},
                      { :wing => :tip, :tail => :fin } ]
      } }
    props = Aduki.to_aduki hsh
    props.should == {
      "foo"         => "bar",
      "bing.boo"    => "wogga",
      "bing.tingle" => "wimp",
      "bing.harpoon[0]" => "shonk",
      "bing.harpoon[1]" => "twaddle",
      "bing.harpoon[2][0]" => "alpha",
      "bing.harpoon[2][1]" => "beta",
      "bing.harpoon[2][2]" => "gamma",
      "bing.harpoon[3].wing" => :tip,
      "bing.harpoon[3].tail" => :fin,
    }
  end
end
