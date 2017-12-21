require 'httparty'
require 'nokogiri'
require 'json'

class Monsters 

    # initialize with arguments    
    def initialize(arguments)
        @arguments = arguments
    end # -- end initialize

    # run items object
    def run
        getPage
        getLocations
        printLocations
    end # -- end run

    # get page as Nokogiri object
    def getPage
        # get specific page from last argument
        page = @arguments[@arguments.length - 1]    
        # get url for specific page
        url = "http://oldschoolrunescape.wikia.com/wiki/#{page}"

        # prints url for debugging
#        puts(url)

        # request page
        @page = HTTParty.get(url)

        # check to see if this was a valid request
        if @page.include? "This page does not exist. Mayhaps it should?"
            # if not valid request, abort 
            abort("Incorrect input. Make sure you spelling is correct. The syntax is:\n\n\tOSQuery -m This_monster\n\nThe first letter of the item must be capitalized with the rest of the letters lowercase, and there must be an underscore between each word with no spaces.")
        end # -- end check for valid request
    end # -- end getPage

    # get table of locations for this monster 
    def getLocations
        # create locations table
        locations = Array.new
 
        # turn page into Nokogiri object
        parsed_page = Nokogiri::HTML(@page)

        # get table of drop info from page
        locations = parsed_page.css("#mw-content-text").css("ul").css("li").css("a").children.map { |r| r.text }

        # prints table for debugging
#        puts("table = #{locations}")

        # save locations globally
        @locations = locations
    end # -- end getLocations

    # print Locations table
    def printLocations
        puts("Locations for #{@arguments[@arguments.length - 1]}:")
        # print each location on its own line
        for i in 0..@locations.length - 1 
            puts("\t#{@locations[i]}")
        end # -- end for loop for printing locations 
    end # -- end printLocations

    # make all methods besides run private
    private :getPage, :getLocations, :printLocations

end # -- end items class 
