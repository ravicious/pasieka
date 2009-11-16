class Typo

  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :blip_id, Integer, :nullable => false, :default => 0
  property :typo, String, :nullable => false
  property :correct_form, String, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_is_number :blip_id
  validates_with_method :is_unique?
  validates_with_method :blip_id, :too_short?

  # Sprawdza, czy obiekt jest unikalny
  # (blip_id i typo są unikalne dla każdego obiektu)
  def is_unique?
    if Typo.all(:blip_id => blip_id, :typo => typo).empty?
      return true
    else
      return [false, "Typo already exists"]
    end
  end

  def too_short?
    if @blip_id.to_s.length < 4
      return [false, "is too short"]
    else
      return true
    end
  end

end
