require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Typo do

  before(:all) { Typo.all.destroy! }
  after(:all) { Typo.all.destroy! }

  it "should save object if it is valid" do

    typo = Typo.new :blip_id => 696969, :typo => 'wat', :correct_form => 'what?'

    typo.valid?.should be_true

    lambda {typo.save}.should change{Typo.all.count}.by(1)

  end

  it "should not save object if it isn't valid" do

    # Puste pola
    first_typo = Typo.new

    # Wypełnione tylko jedno pole
    second_typo = Typo.new :correct_form => 'rotfl'

    # Zbyt krótkie pole blip_id
    third_typo = Typo.new :blip_id => 123, :typo => 'rolf', :correct_form => 'rotfl'

    # Obiekt już istnieje
    fourth_typo = Typo.new :blip_id => 696969, :typo => 'wat', :correct_form => 'what?'

    [first_typo, second_typo, third_typo, fourth_typo].each do |typo|

      typo.valid?.should be_false

      lambda {typo.save}.should_not change(Typo.all, :count).by(1)

    end

  end

end
