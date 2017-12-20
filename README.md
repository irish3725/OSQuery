# OSQuery
OSQuery is a scraping tool in ruby that returns info about Old School Runescape quickly. I'm writing this because my little chromebook struggles to handle opening webpages and running a OS Runscape client at the same time.

So far all OSQuery does is take in an item as an arguement and returns the monsters that drop it, how many each monster drops, and the drop rate at which each monster drops that item.

Example:

    $ ruby OSQuery Blood_rune

The syntax is very specific. It will only read one argument, and that argument must start with an uppercase letter, all of the rest of the letters must be lowercase, and there must be an underscore between each word.

### Installing
 
I this tool is being developed on Debian Linux, and I have not yet tested it on any other operating system.

From Git clone on Debian Linux:

    git clone https://github.com/irish3725/OSQuery.git
    sudo apt-get install ruby-full
    gem install nokogiri
    gem install httparty
    gem install pry

Now to run it:

    cd OSQuery
    ruby OSQuery.rb This_item

