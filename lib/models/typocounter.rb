class TypoCounter

  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :typo, String, :nullable => false
  property :correct_form, String, :nullable => false
  property :counter, Integer, :nullable => false, :default => 0
  property :created_at, DateTime
  property :updated_at, DateTime

  def self.bump_or_create(args)
    # Jeśli nie istnieje obiekt z takim typo
    if TypoCounter.all(:typo => args[:typo]).empty?
      TypoCounter.create(:typo => args[:typo], :correct_form => args[:correct_form], :counter => 1)

    else
      typo_counter = TypoCounter.all(:typo => args[:typo]).first
      typo_counter.bump_counter
    end
  end

  def bump_counter
    self.counter += 1
    self.save
  end

end
