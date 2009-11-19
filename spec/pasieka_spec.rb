require 'spec_helper'

describe Pasieka do
  
  before :each do

    Typo.all.destroy!

  end

  it "should parse messages" do

    Miodek.get_messages.each do |msg|
      Pasieka.parse_message(msg)
      Pasieka.typos.last.should be_a_kind_of Hash
    end

    # Jedna wiadomość Miodka zawiera przynajmniej jeden błąd ortograficzny
    Pasieka.typos.should have_at_least(TEST_MESSAGES.count).typos

  end

  it "should save typos without errors" do

    lambda {Pasieka.save_typos}.should change {Typo.all.count}.by(Pasieka.typos.count)

  end

  it "should clear typos after save" do

    Miodek.get_messages.each do |msg|
      Pasieka.parse_message(msg)
    end

    lambda {Pasieka.save_typos}.should change {Pasieka.typos.count}

  end

  it "should not clear typos after save if proper argument was passed" do
    Pasieka.typos.clear

    Miodek.get_messages.each do |msg|
      Pasieka.parse_message(msg)
    end

    lambda {Pasieka.save_typos(false)}.should_not change {Pasieka.typos.count}

  end

  it "should save typos and create new typo counters" do
    Typo.all.destroy!

    # Dodaj nowe wiadomości
    lambda {
      Miodek.get_messages.each do |msg|
        Pasieka.parse_message(msg)
      end
      Pasieka.save_typos
    }.should change{Typo.all.count}

    # Wszystkie wiadomości już istnieją, nie podbijaj więc licznika
    lambda {
      Miodek.get_messages.each do |msg|
        Pasieka.parse_message(msg)
      end
      Pasieka.save_typos
    }.should_not change{TypoCounter.first.counter}
  end

end
