require "aduki"
require "spec_helper"

describe Aduki do
  it "should return a plain hash structure" do
    hsh = { "foo" => "bar" }
    props = Aduki.to_aduki hsh
    props.should == { "foo" => "bar" }
  end
end
