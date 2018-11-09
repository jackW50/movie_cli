
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
  
  def theater_array 
    MovieCli::Theater.find_by_zip_code(input)
  end 
  
  def reveal_from_zip_code
    puts "-----------"
    puts "\n"
    puts "HERE ARE THE NEARBY THEATERS:"
    puts "********"
    theater_array.each.with_index(1) do |theater, i|
      puts "#{i}. #{theater.name}"
      puts "\n"
      puts "ADDRESS and INFO:"
      puts theater.location
      puts "\n"
      puts "********"
      puts "\n"
    end 
  end 
  
  def reveal_theater_movies(index)
    puts "\n"
    puts "-----------"
    puts "HERE ARE THIS THEATERS MOVIES & SHOWTIMES:"
    puts "********"
    find_by_index(index).movies.each do |movie|
      puts movie.name 
      puts movie.showtimes 
      puts "********"
    end
  end 
  
  def find_by_index(index)
    found = nil 
    theater_array.each.with_index(1) do |theater, i|
      found = theater if i == index
    end 
    found
  end 
  
  def theater_choice
    puts "-----------"
    puts "\n"
    puts "Which theater's movie list would you like to see? Type its number: 1 - #{theater_array.count}"
    choice = gets.strip.to_i
    if choice > 0 && choice <= theater_array.count
       reveal_theater_movies(choice)
       another_theater?
    else 
      puts "I'm sorry, that choice is invalid."
      theater_choice
    end 
  end 
  
  def another_theater? 
    puts "\n"
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
    puts "\n"
    puts "Would you like to search a different area? y/n"
    decision = gets.strip.downcase 
    if decision == "y"
      puts "\n"
      run 
    elsif decision == "n"
      puts "\n"
      puts "Okay, Have a great day!"
    else 
      puts "I'm sorry I do not understand."
      search_again?
    end 
  end 
  
  def already_scraped?
    MovieCli::Theater.all.any? do |theater|
      theater.zip_code == input
    end 
  end 
  
  def any_theaters?
    if theater_array.count > 0
      true 
    else 
      nil 
    end 
  end 
  
  def run 
    get_zip
    if valid_zip? && already_scraped?
      
      if any_theaters?
        reveal_from_zip_code
        theater_choice
        search_again?
      else 
        puts "I'm sorry it looks like there are no theaters in this area."
        search_again?
      end 
      
    elsif valid_zip? && !already_scraped?
      create_theaters
      
      if any_theaters?
        reveal_from_zip_code
        theater_choice
        search_again?
      else 
        puts "I'm sorry it looks like there are no theaters in this area."
        search_again?
      end 
      
    else 
      puts "Invalid Zip Code. Please Try Again."
      run
    end 
  end 
end 