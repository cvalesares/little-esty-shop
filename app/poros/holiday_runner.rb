require 'faraday'
require 'json'
require 'pry'
require './app/poros/holiday_search'

search = HolidaySearch.new
search.holiday_information.each do |holiday|
  p holiday.name
  p holiday.date
end 
