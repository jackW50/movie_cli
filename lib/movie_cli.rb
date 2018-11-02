#require "movie_cli/version"
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
    puts "Hello! Sounds like you want to see a movie."
    puts "Lets see if we can help."
  end 
  
  def get_zip 
    puts "What is your 5 number zip code?"
    @input = gets.strip
  end 
  
  def valid_zip?
    if input.length == 5 && input.match(/[0-9]{5}/)
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
      puts "HERE ARE NEARBY THEATERS AND MOVIES:"
      puts "\n"
      Theater.all.each_with_index do |theater, i|
        puts "THEATER #{i + 1}"
        puts theater.name
        puts "\n"
        puts "ADDRESS: #{theater.location}"
        puts "\n"
        puts "MOVIES & SHOWTIMES"
        puts "\n"
        theater.movies.each do |movie|
          puts movie.name
          puts movie.showtimes
        end 
        puts "\n\r"
      end 
    else 
      nil
    end 
  end 
  
  def run 
    get_zip
    if valid_zip? 
      reveal_theater_info
    else 
      puts "Invalid Zip Code. Please Try Again."
      run
    end 
  end 
    
end 