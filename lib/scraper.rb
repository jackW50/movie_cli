require 'pry'
require 'open-uri'
require 'nokogiri'
require 'capybara/poltergeist'

# http://www.movies.com/movie-times/63015-movie-times
class Scraper
  attr_accessor :path 
  
  def initialize(path)
    @path = path 
  end 
  
  def theater_scraper
    html = open(path)
    doc = Nokogiri::HTML(html)
    doc.css("ul li")
    #binding.pry
  end 
  
  def theater_name
    doc.css("ul li div.theaterInfo h2 a").text 
  end 
  
  def theater_location
    doc.css("ul li div.theaterInfo p")[2].text.split("\r")
  end 
  
  def theater_movies
  end 
    
  def theater_parser
  end 
  
end 