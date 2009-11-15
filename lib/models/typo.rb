class Typo

  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :blip_id, Integer, :nullable => false, :default => 0
  property :typo, String, :nullable => false
  property :correct_form, String, :nullable => false
  property :created_at, DateTime
  property :updated_at, DateTime

  validates_is_number :blip_id

end
