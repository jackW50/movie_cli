require 'nokogiri'

class Theater
  attr_accessor :name, :location, :movies
  
  @@all = []
  
  def initialize(name)
    @name = name 
    @movies = []
    self.class.all << self 
  end 
  
  def self.all 
    @@all 
  end 
  
  def self.create_from_scraper(theaters)
    theaters.each do |theater|
      
    end 
  end 

end 