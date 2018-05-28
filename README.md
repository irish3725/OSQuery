# OSQuery
OSQuery is a scraping tool in ruby that returns info about Old School Runescape quickly. I'm writing this because my little chromebook struggles to handle opening webpages and running an OS Runscape client at the same time.

So far all OSQuery does is take in an item as an arguement and returns the monsters that drop it, how many each monster drops, and the drop rate at which each monster drops that item.

Example:

    $ ruby OSQuery.rb -i Blood_rune

The syntax is very specific. The first argument needs to be a valid option, and the second needs to be an object. The object must start with an uppercase letter, all of the rest of the letters must be lowercase, and there must be an underscore between each word.

### Installing OSQuery

In order to be able to run OSQuery, you must install Ruby, and the two gems nokogiri and httparty, and feh. Ruby and feh can be installed via your package manager, and the gems must be installed with gem. 
    
### Running OSQuery

Now to run it:

    cd OSQuery
    ruby OSQuery.rb -i This_item

### Options

    -i      Get info about an item
    -m      Get info about a monster 
    -t      Get info about a treasure trails clue
 
For most clues, type the first few words of the clue out after the -t flag and it will figure out what kind of clue it is and show the solution. 
Example: 

    ruby OSQuery.rb -t Beckon in the Digsite

If you have a puzzel box, give the -t option and the name of the box (Castle/Cerberus/Gnome/Tree/Troll/Zulrah)
Example:

    ruby OSQuery.rb -t Cerberus

