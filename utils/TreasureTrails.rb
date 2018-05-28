require 'httparty'
require 'nokogiri'
require 'json'
require 'open-uri'

class TreasureTrails

    #initialize with arguments
    def initialize(arguments)
        @arguments = arguments
    end # -- end initialize

    #run TreasureTrails object
    def run
        getPages
        findPage
        #printSolution
    end # -- end run

    # get all treasure trails guide pages
    def getPages
        @urls = Array.new(5, "http://oldschoolrunescape.wikia.com/wiki/Treasure_Trails/Guide/")
        @urls[0] = @urls[0] + "Anagrams"
        @urls[1] = @urls[1] + "Ciphers"
        @urls[2] = @urls[2] + "Coordinates"
        @urls[3] = @urls[3] + "Cryptics"
        @urls[4] = @urls[4] + "Emote_clues"
        @pages = Array.new(5)
        @urls.each_with_index {|url, index| @pages[index] = HTTParty.get(@urls[index])}
#        @pages.each_with_index { |page, index| page = 
        
        @pages.each {|page| if page.include? "This page does not exist. Mayhaps it should?"; puts("invalid url: #{@urls[index]}") end}
    end # -- end getPages

    # search all pages for clue
    def findPage
        puts("searching for clue: #{@arguments}")
        @pages.each_with_index {|page, index| if page.include? @arguments; printSolution(page, @urls[index], @arguments) end}
    end # -- end findPage

    # gets table for page
    def anagrams(page, clue)
        #turn page into nokogiri object
        parsed_page = Nokogiri::HTML(page)
        
        # get row in table
        parsed_page.css(".wikitable").children.each { |r| if r.text.include? clue; @row = r.text end}

        # get each value from row in table
        @table = @row.split("\n")

        # print info about anagrams
        if @table.length == 6
            puts("Anagram: #{@table[1]}")
            puts("Solution: #{@table[2]}")
            puts("Location: #{@table[3]}")
            puts("Answer: #{@table[4]}")
            puts("Level: #{@table[5]}")
        else
            puts("found this:\n#{@table}\nThat doesn't seem right...")
        end
    end # -- end anagrams

    def ciphers(page, clue)
        #turn page into nokogiri object
        parsed_page = Nokogiri::HTML(page)
        
        # get row in table
        parsed_page.css(".wikitable").children.each { |r| if r.text.include? clue; @row = r.text end}
        table = @row.split("\n")

        if table.length == 6
            puts("Cipher: #{table[1]}")
            puts("Solution: #{table[2]}")
            puts("Location: #{table[3]}")
            puts("Answer: #{table[4]}")
            puts("Level: #{table[5]}")
        else
            puts("found this table: \n#{table}\nThat doesn't seem right...")
        end
    end # -- end ciphers

    def coordinates(page, clue)
        puts("coordinates not yet implemented")
    end # -- end coordinates

    def cryptics(page, clue)
        
        #turn page into nokogiri object
        parsed_page = Nokogiri::HTML(page)
        
        # get row in table
        parsed_page.css(".wikitable").children.each { |r| if r.text.include? clue; @row = r end}
        # get images from that row

        # get url for image of map
        @row.css("a").css(".image").css("img").each { |r| if r["src"].include? "Cryptic_clue" then @map_url = r["src"] end }

        # split items in row
        @row = @row.text
        table = @row.split("\n")

        # print info about clue
        puts("Clue: #{table[1]}")
        puts("Notes: #{table[2]}")
        puts("Level: #{table[5]}")

        # display image of map (currently using feh)
        display(@map_url)

    end # -- end cryptics

    def emotes(page, clue)

        #turn page into nokogiri object
        parsed_page = Nokogiri::HTML(page)
        
        # get row in table
        parsed_page.css(".wikitable").children.each { |r| if r.text.include? clue; @row = r end}

        # get map image from row
        @row.css("a").css(".image").css("img").each { |r| if r["src"].include? "Emote_clue" then @map_url = r["src"] end }

        @row = @row.css("td").map { |r| r.text}
        table = ["\nClue: #{@row[0].tr("\n", '')}", "\nNotes: #{@row[2].tr("\n", '')}", "\nLevel: #{@row[4].tr("\n", '')}"]

        # print outputs in table
        table.each { |output| puts(output) }

        display(@map_url)
    end # -- end emotes

    def display(map_url)
        
        # path to map image
        path = "images/map.png"
        
        # open image and write to file
        File.open(path, "wb") do |save_file|
            open(map_url, "rb") do |read_file|
                save_file.write(read_file.read)
            end
        end

        # display image using feh (-Z option zooms image to fill window)
        `feh -Z #{path}`

    end # -- end display

    # prints solution
    def printSolution(page, url, clue)
        if url.include? "Anagrams"
            anagrams(page, clue)
        elsif url.include? "Ciphers"
            ciphers(page, clue)
        elsif url.include? "Coordinates"
            coordinates(page, clue)
        elsif url.include? "Cryptics"
            cryptics(page, clue)
        elsif url.include? "Emote_clues"
            emotes(page, clue)
        end
    end # -- end printSolution

end # -- end TreasureTrails class


