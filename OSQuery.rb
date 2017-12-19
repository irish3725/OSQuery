#!/usr/bin/env ruby

require 'httparty'
require 'nokogiri'
require 'json'
require 'pry'

# get input arguments
input = ARGV
# get specific page
page = input[0]
# get url for specific page
url = "http://oldschoolrunescape.wikia.com/wiki/#{page}"
#url = "http://en.wikipedia.org/wiki/#{page}"

puts(url)

# request page
page = HTTParty.get(url)

# turn page into Nokogiri object
parsed_page = Nokogiri::HTML(page)

dropped_by = parsed_page.css(".sortable").css("td").css("a").children.map { |by| by.text }.compact
rate = parsed_page.css(".sortable").css("td").css("small").children.map { |r| r.text }.compact

puts("Dropped by:#{dropped_by} at rate #{rate}")

