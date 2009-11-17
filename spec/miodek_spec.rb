require 'spec_helper'

describe Miodek do

  before :all do
    @miodek = Miodek.new
  end

  it "should read credentials from the config file" do

    @miodek.user.should_not be_nil
    @miodek.password.should_not be_nil

  end

  it "should get recent messages" do
    @miodek.get_messages.should be_a_kind_of Array
  end

end
