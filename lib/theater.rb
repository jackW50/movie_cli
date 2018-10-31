require 'nokogiri'

class Theater
  attr_accessor :name, :location, :movies
  
  @@all = []
  
  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self.class.all << self 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.create_from_scraper(theater_hash)
    theater_hash.each do |key, value|
      Theater.new(value)
    end 
  end
  
  def movie_converter
  end 
      
end 