#require "movie_cli/version"
#require "../config/environment"
require 'pry'

module MovieCli
  # Your code goes here...
end

class Movie_Cli 
  attr_accessor :input, :site
  
  def initialize
    @site = "http://www.movies.com"
  end 
  
  def greeting 
    puts "Hello, sounds like you want to see a movie"
    puts "Lets see if we can help you with your search"
    puts "What is your 5 number zip code?"
    @input = gets.strip
  end 
  
  def valid_zip?
    if input.length == 5 #&& #make sure that greeting is numbers not letters
      true
    else
      nil
    end
  end 
  
  
  def site_interpolation(web_site = self.site, zip_code = self.input)
      "#{web_site}" + "/movie-times/" + "#{zip_code}-movie-times"
  end 
  
  def scrape_info 
    if site_interpolation != nil 
      Scraper.new(site_interpolation)
    else 
      nil
    end 
  end 
  
  def parse_info 
    if scrape_info != nil 
      scrape_info.theater_hash
    else 
      nil 
    end 
  end 
  
  def create_theaters
    if parse_info != nil
      Theater.create_from_scraper(parse_info)
    else
      nil 
    end 
  end 
  
  def reveal_theater_info
    if create_theaters != nil 
      Theater.all.each do |theater|
        puts theater.name 
        puts theater.location
        theater.movies.each do |movie|
          puts movie.name
          puts movie.showtimes
        end 
      end 
    else 
      nil
    end 
  end 
  
  def run 
    greeting
    if valid_zip? 
      binding.pry
      reveal_theater_info
    else 
      nil
    end 
  end 
    
end 