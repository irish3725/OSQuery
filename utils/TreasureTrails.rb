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
        getPages
        searchPages
        printSolution
    end # -- end run

    # get all treasure trails guide pages
    def getPages
        puts("getPages not yet implemented")
    end # -- end getPages

    # search all pages for clue
    def searchPages
        puts("searchPages not yet implemented")
    end # -- end searchPages

    # prints solution
    def printSolution
        puts("printSolution not yet implemented")
    end # -- end printSolution

end # -- end TreasureTrails class


