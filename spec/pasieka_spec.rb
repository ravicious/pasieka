require 'spec_helper'

describe Pasieka do
  
  before :all do
    @pasieka = Pasieka.new
    @miodek = Miodek.new
  end

  before :each do

    Typo.all.destroy!

  end

  it "should parse messages" do

    @miodek.get_messages.each do |msg|
      @pasieka.parse_message(msg)
      @pasieka.typos.last.should be_a_kind_of Hash
    end

    # Jedna wiadomość Miodka zawiera przynajmniej jeden błąd ortograficzny
    @pasieka.typos.should have_at_least(TEST_MESSAGES.count).typos

  end

  it "should save typos without errors" do

    lambda {@pasieka.save_typos}.should change {Typo.all.count}.by(@pasieka.typos.count)

  end

  it "should clear typos after save" do

    @miodek.get_messages.each do |msg|
      @pasieka.parse_message(msg)
    end

    lambda {@pasieka.save_typos}.should change {@pasieka.typos.count}

  end

  it "should not clear typos after save if proper argument was passed" do
    @pasieka.typos.clear

    @miodek.get_messages.each do |msg|
      @pasieka.parse_message(msg)
    end

    lambda {@pasieka.save_typos(false)}.should_not change {@pasieka.typos.count}

  end

end
