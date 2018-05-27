require 'httparty'
require 'nokogiri'
require 'json'

class TreasureTrails

    #initialize with arguments
    def initialize(arguments)
        @arguments = arguments
    end

    #run TreasureTrails object
    def run
        getPages
        searchPages
        printSolution
    end
