#require "movie_cli/version"
#require "../config/environment"


module MovieCli
  # Your code goes here...
end

class Movie_Cli 
  #I want to interact with user and return them information
  def greeting 
    puts "Hello, sounds like you want to see a movie"
    puts "Lets see if we can help you with your search"
    puts "What is your 5 number zip code?"
  end 
  
  def zip 
    greeting
    input = gets.strip
  end 
  
  def valid_zip?
    if zip.length == 5 #&& #make sure that greeting is numbers not letters
      true
    else
      nil
    end
  end 
  
  
  def site_interpolation(site = "http://www.movies.com", zip_code= zip)
    if valid_zip?
      "#{site}" + "/movie-times/" + "#{zip_code}-movie-times"
    else 
      nil 
    end 
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
      Theater.new(parse_info)
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
    reveal_theater_info
  end 
    
end 