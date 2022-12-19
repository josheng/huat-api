# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'nokogiri'
require 'open-uri'
# require 'pry'
require 'selenium-webdriver'
require 'webdrivers'

# variables

URL = 'https://www.singaporepools.com.sg/en/product/pages/4d_results.aspx'

puts 'Scraping URL with Selenium'
# Selenium portion
# Set up the headless browser
options = Selenium::WebDriver::Chrome::Options.new(args: ['headless'])
driver = Selenium::WebDriver.for :chrome, options: options

# Load the website
driver.get(URL)

# Wait for the page to load and the JavaScript code to be executed
wait = Selenium::WebDriver::Wait.new(timeout: 10)
wait.until { driver.find_element(:tag_name, 'select') }

# Select the element with the event listener
dropdownbox = driver.find_element(:tag_name, 'select')
ddboptions = dropdownbox.find_elements(:tag_name, 'option')

puts 'Proceeding with Nokogiri'

# Nokogiri portion
def scrap_result(querystring)
  top_prize = []
  starter = []
  consolation = []
  html = URI.open(URL + '?' + querystring) # open the html of the page
  doc = Nokogiri::HTML(html) # create a nokogiri doc based on that html

  # draw date and draw number
  info_element = doc.search('.table.table-striped.orange-header thead')
  draw_date = info_element.search('.drawDate').text
  draw_number = info_element.search('.drawNumber').text.split(' ')[-1]

  # top prize
  top_element = doc.search('.table.table-striped.orange-header tbody')

  top_element.each do |element|
    top_three = element.text.strip.delete("\t\r\n").split(' ')
    top_prize << top_three[2] << top_three[5] << top_three[8]
  end

  # starter numbers
  starters_element = doc.search('.tbodyStarterPrizes')

  starters_element.each do |element|
    starter = element.text.strip.delete("\t\r\n").split(' ')
  end

  # consolation numbers
  consolation_element = doc.search('.tbodyConsolationPrizes')

  consolation_element.each do |element|
    consolation = element.text.strip.delete("\t\r\n").split(' ')
  end

  {draw_date: draw_date, draw_number: draw_number, first: top_prize[0], second: top_prize[1], third: top_prize[2], starter: starter, consolation: consolation }
end

ddboptions.each do |option|
  p 'Storing results into DB'
  resulthash = scrap_result(option.attribute('querystring'))
  result = Fourd.new(
    drawdate: resulthash[:draw_date],
    drawnumber: resulthash[:draw_number],
    first: resulthash[:first],
    second: resulthash[:second],
    third: resulthash[:third],
    starter: resulthash[:starter],
    consolation: resulthash[:consolation]
  )
  p "Saving draw number #{result.drawnumber}"
  result.save!
end

# Close the browser
driver.quit
p 'Scraping complete!'
