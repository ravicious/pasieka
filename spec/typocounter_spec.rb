require 'spec_helper'

describe Typo do
  before(:all) {
    Typo.all.destroy!
    TypoCounter.all.destroy!
  }

  after(:all) {
    Typo.all.destroy!
    TypoCounter.all.destroy!
  }

  it "should create a new object if it's valid" do
    lambda { TypoCounter.bump_or_create :typo => 'ravuciosu', :correct_form => 'ravicious' }.should change{TypoCounter.all.count}.by(1)
  end

  it "should bump counter if an object already exists" do
    TypoCounter.bump_or_create :typo => 'blpi', :correct_form => 'blip'

    lambda { TypoCounter.bump_or_create :typo => 'blpi', :correct_form => 'blip' }.should change{
      TypoCounter.all(:typo => 'blpi').first.counter
    }.by(1)
  end

  it "should not create a new object if it isn't valid" do

    # Puste pola
    first_typo = TypoCounter.new

    # Wypełnione tylko jedno pole
    second_typo = TypoCounter.new :correct_form => 'rotfl'

    third_typo = TypoCounter.new :typo => 'rolf'

    [first_typo, second_typo, third_typo].each do |typo|

      typo.valid?.should be_false

      lambda {typo.save}.should_not change(TypoCounter.all, :count).by(1)

    end

  end

end
