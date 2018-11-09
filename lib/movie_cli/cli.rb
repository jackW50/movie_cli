
class MovieCli::Cli 
  attr_accessor :input
  
  def initialize
    greeting
    puts "\n"
  end 
  
  def greeting
    puts "Hello! Sounds like you want to see a movie."
    puts "Let's see if we can help."
  end 
  
  def get_zip 
    puts "Please enter 5 number zip code to search?"
    @input = gets.strip
  end 
  
  def valid_zip?
    if input.length == 5 && input.match(/[0-9]{5}/)
      true
    else
      nil
    end
  end 
  
  def scrape_info 
      MovieCli::Scraper.new(input).theater_hash
  end 
  
  def create_theaters
     MovieCli::Theater.create_from_scraper(scrape_info)
  end 
  
  def reveal_from_zip_code
    MovieCli::Theater.find_by_zip_code(input).each.with_index(1) do |theater, i|
      puts "#{i}. #{theater.name}"
      puts "ADDRESS and INFO:"
      puts theater.location
    end 
  end 
  
  def theater_choice
    puts "Which theater's movie list would you like to see? Type its number: 1 - #{MovieCli::Theater.find_by_zip_code(input).count}"
    choice = gets.strip.to_i
    if choice > 0 && choice <= MovieCli::Theater.find_by_zip_code(input).count
       MovieCli::Theater.find_by_index(choice, MovieCli::Theater.find_by_zip_code(input)).movies.each do |movie|
         puts movie.name 
         puts movie.showtimes 
       end 
       another_theater?
    else 
      puts "I'm sorry, that choice is invalid."
      theater_choice
    end 
  end 
  
  def another_theater? 
    puts "would you like to see another theater? y/n"
    second_choice = gets.strip.downcase 
    if second_choice == "y"
      reveal_from_zip_code
      theater_choice
    elsif second_choice == "n" 
      nil
    else 
      puts "I'm sorry I do not understand"
      another_theater?
    end 
  end 
  
  def search_again?
    puts "Would you like to search a different area? y/n"
    decision = gets.strip.downcase 
    if decision == "y"
      run 
    elsif decision == "n"
      puts "Okay, Have a great day!"
    else 
      puts "I'm sorry I do not understand."
      search_again?
    end 
  end 
  
  def already_scraped?
    MovieCli::Scraper.all_zips.include?(input)
  end 
  
  def repeat_reveal_from_memory
    MovieCli::Theater.find_by_zip(input).each.with_index(1) do |theater, i|
      puts "#{i}. #{theater.name}"
      puts "ADDRESS and INFO:"
      puts theater.location
    end 
  end 
  
  def run 
    get_zip
    if valid_zip? && already_scraped?
      reveal_from_zip_code
      theater_choice
      search_again?
    elsif valid_zip? && !already_scraped?
      create_theaters
      reveal_from_zip_code
      theater_choice
      search_again?
    else 
      puts "Invalid Zip Code. Please Try Again."
      run
    end 
  end 
end 