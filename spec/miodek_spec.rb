require 'spec_helper'

describe Miodek do

  before :all do
    @miodek = Miodek.new
  end

  it "should read credentials from the config file" do

    @miodek.user.should_not be_nil
    @miodek.password.should_not be_nil

  end

=begin

    To prawdopodobnie *działa*. Jednak pobranie wiadomości zabiera
    kilka cennych sekund, a dla mnie, użytkownika iPlusa,
    czas jest bardzo ważny.

    Dlatego na razie porzucam testowanie tego fragmentu kodu.

  it "should get recent messages" do
    @miodek.get_messages.should be_a_kind_of Array
  end

=end

end
