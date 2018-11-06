
class Theater
  attr_accessor :name, :location, :movies
  
  @@all = []
  
  def initialize(attributes = nil)
    save 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.create_from_scraper(theater_hash)
    theater_hash.each do |key, theater_attributes|
      Theater.new(theater_attributes).tap do |t|
        theater_attributes.each do |key, value|
          t.send(("#{key}="), value)
        end 
      end 
    end 
  end
  
  def save 
    self.class.all << self 
  end 
end 