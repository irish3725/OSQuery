require 'httparty'
require 'nokogiri'
require 'json'

class TreasureTrails

    #initialize with arguments
    def initialize(arguments)
        @arguments = arguments
    end # -- end initialize

    #run TreasureTrails object
    def run
        puts("arguments: #{@arguments}")
        getPages
        findPage
        #printSolution
    end # -- end run

    # get all treasure trails guide pages
    def getPages
        @urls = Array.new(6, "http://oldschoolrunescape.wikia.com/wiki/Treasure_Trails/Guide/")
        @urls[0] = @urls[0] + "Anagrams"
        @urls[1] = @urls[1] + "Challenge_scrolls"
        @urls[2] = @urls[2] + "Ciphers"
        @urls[3] = @urls[3] + "Coordinates"
        @urls[4] = @urls[4] + "Cryptics"
        @urls[5] = @urls[5] + "Emote_clues"
        @urls.each {|url| puts(url)}
        @pages = Array.new(6)
        @urls.each_with_index {|url, index| @pages[index] = HTTParty.get(@urls[index])}
#        @pages.each_with_index { |page, index| page = 
        
        @pages.each {|page| if page.include? "This page does not exist. Mayhaps it should?"; puts("invalid url: #{@urls[index]}") end}
    end # -- end getPages

    # search all pages for clue
    def findPage
        puts("searching for clue: #{@arguments}")
        @pages.each_with_index {|page, index| if page.include? @arguments; printSolution(page, @urls[index], @arguments) end}
        puts("findPage not yet implemented")
    end # -- end findPage

    # prints solution
    def printSolution(page, url, clue)
        puts("url: #{url}\nclue: #{clue}")
        puts("printSolution not yet implemented")
    end # -- end printSolution

end # -- end TreasureTrails class


