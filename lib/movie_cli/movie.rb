class MovieCli::Movie 
  attr_accessor :name, :showtimes 
  
  def initialize(name, showtimes)
    @name = name 
    @showtimes = showtimes 
  end 
end 