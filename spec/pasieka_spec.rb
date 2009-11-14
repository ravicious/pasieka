require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Pasieka do
  
  before :all do
    @pasieka = Pasieka.new
  end

  it "should parse messages" do

    # Jedna wiadomość Miodka zawiera przynajmniej jeden błąd ortograficzny
    lambda {
      @pasieka.parse_message(TEST_MESSAGES.first['body'])
    }.should change { @pasieka.typos.count }.by_at_least(1)

    TEST_MESSAGES.each do |msg|
      @pasieka.parse_message(msg['body'])
      @pasieka.typos.last.should be_a_kind_of Hash
    end

    @pasieka.typos.should have_at_least(TEST_MESSAGES.count).typos

  end
end
