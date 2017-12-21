#!/usr/bin/env ruby

require_relative 'utils/Items'
require_relative 'utils/Monsters'

# extracts options from input
def getOptions
    @options = Array.new
    # format of options argument
    optionsPattern = Regexp.new(/\-[\w]+/)
    # check to see if options are formatted correctly
    if optionsPattern.match(ARGV[0])
        # get each option and push them to an array 
        # start at 1 to ignore - 
        for i in 1..ARGV[0].length - 1
            @options.push(ARGV[0][i])
        end # -- end for loop to get options
    else
        abort("First argument needs to be an option.\nExample:\n\t ruby OSQuery -i Blood_rune")
    end # -- end valid options check
end # -- end get options

def main 
    getOptions

    # check to see if options suggests we need to look for items
    if @options[0] == "i"
        items = Items.new(@options.push(ARGV[1]))
        items.run
    # check to see if options suggest we need to look for monsters
    elsif @options[0] == "m"
        monsters = Monsters.new(@options.push(ARGV[1])) 
        monsters.run
    else
        abort("#{ARGV[0]} is not a valid option")
    end # -- end check for items option 
    
end # -- end main 

main

