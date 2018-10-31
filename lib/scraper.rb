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
    doc.css("ul.theaterList li")
  end 
  
  def theater_hash 
    theaters = {}
    theater_scraper.each_with_index do |theater, i|
      theaters[i][name] = theater.css("div.theaterInfo h2 a").text
      theaters[i][location] = theater.css("div.theaterInfo p").text.strip
      theaters[i][movies] = add_movies(theater)
    end 
    theaters
  end 
      
  def add_movies(theater)
    theater.css("ul.movieListings li").collect do |movie|
      movie.css("div.info p a").text + " " + (movie.css("ul.showtimes li a").text.strip)
    end 
  end 
  
end 