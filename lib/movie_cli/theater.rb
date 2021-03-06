
class MovieCli::Theater
  attr_accessor :name, :location, :movies, :zip_code
  
  @@all = []
  
  def initialize(attributes = nil)
    save 
  end 
  
  def self.all 
    @@all
  end 
  
  def self.create_from_scraper(theater_hash)
    theater_hash.each do |key, theater_attributes|
      MovieCli::Theater.new(theater_attributes).tap do |t|
        theater_attributes.each do |key, value|
          t.send(("#{key}="), value)
        end 
      end 
    end 
  end
  
  def self.find_by_zip_code(zip_code)
    all.select {|theater| theater.zip_code == zip_code }
  end 
  
  def save 
    self.class.all << self 
  end 
end 