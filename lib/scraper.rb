require 'pry'
require 'open-uri'
require 'nokogiri'
require 'capybara/poltergeist'


class Scraper
  attr_accessor :path 
  
  def initialize(path)
    @path = path 
  end 
  
  def theater_scraper
    html = open(path)
    doc = Nokogiri::HTML(html)
    #binding.pry
  end 
  
  def theater_parser
  end 
  
end 