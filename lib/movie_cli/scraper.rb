
class MovieCli::Scraper
  attr_reader :zip_code
  
  def initialize(zip)
    @zip_code = zip
  end 
  
  def site_interpolation
    "http://www.movies.com/movie-times/" + "#{self.zip_code}-movie-times"
  end 
  
  def theater_scraper
    html = open(site_interpolation)
    doc = Nokogiri::HTML(html)
    doc.css("ul.theaterList li")
  end 
  
  def theater_hash 
    theaters = {}
    theater_scraper.each_with_index do |theater, i|
      theaters[i] = {
          "name" => theater_name(theater), "location" => theater_location(theater), "movies" => add_movies(theater) 
        }
    end 
    theaters.each do |key, value|
      value.delete_if {|key, value| value == ""}
    end 
    theaters.delete_if {|key, value| value == {}} 
    theaters.each {|key, value| value["zip_code"] = zip_code}
    theaters
  end 
  
  def parse_movies(theater)
    theater.css("ul.movieListings li").collect do |movie|
      movie.css("div.info p a").text + "***" + (movie.css("ul.showtimes li").text.strip)
    end 
  end 
  
  def add_movie_strings(theater)
    if parse_movies(theater) == [] || parse_movies(theater) == nil 
      ""
    else 
      movie_and_times_array = parse_movies(theater).delete_if {|x| x == "***"}.collect {|x| x.split("***")}
      
      movie_and_times_array.each do |movie_and_times|
        movie_and_times[1] = movie_and_times[1].gsub(/(?<=:\w{2})(?=\w)/, " ").delete "am"
      end 
      movie_and_times_array
    end 
  end 
  
  def add_movies(theater)
    if add_movie_strings(theater) == ""
      ""
    else 
      add_movie_strings(theater).collect do |movie|
        MovieCli::Movie.new(movie[0], movie[1])
      end 
    end 
  end 
    
  def theater_name(theater)
    theater.css("div.theaterInfo h2 a").text.strip 
  end 
  
  def theater_location(theater)
    theater_address_array = theater.css("div.theaterInfo p").text.strip.split("\r")
    
    theater_address_array.collect {|address_element| address_element.strip}.delete_if {|address_element| address_element == "Print at Home" || address_element == "MapMore info"}.join(" ")
  end 
end 