require 'spec_helper'

describe Miodek do

  it "should read credentials from the config file" do

    Miodek.user.should_not be_nil
    Miodek.password.should_not be_nil

  end

  it "should get recent messages" do
    Miodek.get_messages.should be_a_kind_of Array
  end

end
