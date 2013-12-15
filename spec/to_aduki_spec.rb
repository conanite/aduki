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
end
