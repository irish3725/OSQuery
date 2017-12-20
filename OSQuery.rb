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

if page.include? "This page does not exist. Mayhaps it should?"
    abort("\nIncorrect input. The syntax is:\n\n\tOSQuery This_item\n\nThe first letter of the item must be capitalized with the rest of the letters lowercase, and there must be an underscore between each word with no spaces.")
end

# turn page into Nokogiri object
parsed_page = Nokogiri::HTML(page)

dropped_by = 
table = parsed_page.css(".sortable").css("td").children.map { |r| r.text }

#puts("table = #{table}")
state = 0

# create arrays to hold values about item info
monster = Array.new
amount = Array.new
rate = Array.new

# parse table
while table.length > 0 do
    # get next value and remove all whitespace
#    value = table.shift.gsub(/(\W|^\;)/, "") 
    value = table.shift.strip 
  
#    if state == 0 or state == 2
#        value.gsub(/\d/, "")
#    end
 
    # looking for monster that drops 
    if state == 0 and value != ""
        monster.push(value)
        state = 1
    # removing monster cb lvl 
    elsif state == 1 and value != "" 
        state = 2 
    # looking for amount dropped
    elsif state == 2 and value != "" 
        amount.push(value)
        state = 3 
    # looking for rarity 
    elsif state == 3 
        # check to see if we find expected rarity 
        if value == "Always" or value == "Common" or value == "Uncommon" or value == "Rare" or value == "Very rare"
            rate.push(value)
            state = 4 
        end 
        # looking for exact rate ( hence "(" ) 
        if state == 4 
            if table[0] != nil and table[0].include? "("
                index = rate.length - 1 
                rate[index] = rate[index] + " " + table.shift 
            end 
            state = 0
        end 
    end 
end

# print found values
puts("Monster\t\t\tAmount\t\tRate")
puts("_______\t\t\t______\t\t____")
for i in 0..monster.length - 1
    printf "%-20s\t%-10s\t%s\n", monster[i], amount[i], rate[i]
end

