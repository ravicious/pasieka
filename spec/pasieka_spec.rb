require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Pasieka do
  
  before :all do
    @pasieka = Pasieka.new
  end

  before :each do

    repository(:test) do
      Typo.all.destroy!
    end

  end

  it "should parse messages" do

    # Jedna wiadomość Miodka zawiera przynajmniej jeden błąd ortograficzny
    lambda {
      @pasieka.parse_message(TEST_MESSAGES.first)
    }.should change { @pasieka.typos.count }.by_at_least(1)

    TEST_MESSAGES.each do |msg|
      @pasieka.parse_message(msg)
      @pasieka.typos.last.should be_a_kind_of Hash
    end

    @pasieka.typos.should have_at_least(TEST_MESSAGES.count).typos

  end

  it "should save typos without errors" do
    repository(:test) do
      lambda {@pasieka.save_typos}.should change {Typo.all.count}.by(@pasieka.typos.count)
    end
  end

  it "should clear typos after save" do

    TEST_MESSAGES.each do |msg|
      @pasieka.parse_message(msg)
    end

    repository(:test) do
      lambda {@pasieka.save_typos}.should change {@pasieka.typos.count}
    end

  end

  it "should not clear typos after save if proper argument was passed" do
    @pasieka.typos.clear

    TEST_MESSAGES.each do |msg|
      @pasieka.parse_message(msg)
    end

    repository(:test) do
      lambda {@pasieka.save_typos(false)}.should_not change {@pasieka.typos.count}
    end
  end

end
