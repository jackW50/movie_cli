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
    #binding.pry
    theater_scraper.each_with_index do |theater, i|
      theaters[i] = {
          "name" => theater_name(theater), "location" => theater_location(theater), "movies" => add_movies(theater) 
        }
    end 
    theaters.each do |key, value|
      value.delete_if {|key, value| value == ""}
    end 
    theaters.delete_if {|key, value| value == {}}
  end 
      
  def add_movies(theater)
    #binding.pry
    a = theater.css("ul.movieListings li").collect do |movie|
      movie.css("div.info p a").text + "***" + (movie.css("ul.showtimes li").text.strip)
    end
    if a == [] || a == nil
      "" 
    else 
      a.delete_if {|x| x == "***"}
      b = a.collect {|x| x.split("***")}
      b.each do |x|
        x[1] = x[1].gsub(/(?<=:\w{2})(?=\w)/, " ").delete "am"
      end 
      new_array = []
      b.each do |movie|
        Movie.new(movie[0], movie[1]).tap do |m|
          new_array << m
        end
      end 
      new_array
    end 
  end 
  
  def theater_name(theater) 
    theater.css("div.theaterInfo h2 a").text.strip 
  end 
  
  def theater_location(theater)
    theater.css("div.theaterInfo p").text.strip
  end 
  
end 