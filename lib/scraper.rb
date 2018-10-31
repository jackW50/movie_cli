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
    binding pry
    html = open(path)
    doc = Nokogiri::HTML(html)
    doc.css("ul.theaterList li")
    #binding.pry
  end 
  
  def theater_name_parser 
    theater_scraper.collect {|theater| theater.css("div.theaterInfo h2 a").text}.uniq 
    #return array of theater names 
  end
  
  def theater_name
    doc.css("div.theaterInfo h2 a").text 
  end 
  
  def theater_location_parser
    theater_scraper.collect {|theater| theater.css("div.theaterInfo p").text.strip}.uniq
    # an array for each theaters location.
  end 
  
  def theater_location
     a =doc.css("div.theaterInfo p")[2].text.strip.split("\r").uniq
     a.collect {|i| i.match(/\w+/)}
     a 
  end 
  
  def movie_listings_parser 
    a = theater_scraper.css(ul.movieListings li)
  
  def theater_movies
    movie_name = doc.css("ul.movieListings li div.info p")[0].text.strip 
    movie_rating_duration = doc.css("ul.movieListings li div.info p")[1].text.strip 
    movietimes = doc.css("ul li div.showtimesWrapper ul.showtimes").text
  end 
    
  def theater_parser
  end 
  
end 