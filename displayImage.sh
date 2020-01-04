#!/bin/bash

## script based on z3bra's:
## http://blog.z3bra.org/2014/01/images-in-terminal.html

# location for binary that displays image
BINARY="/usr/lib/w3m/w3mimgdisplay"
# get image from input
IMAGE=$1
# padding
PADDING=20
# size of lines is hardcoded for now
COLUMNSIZE=8
ROWSIZE=14
# get number of columns that fit on screen
COLUMNS=$(tput cols)
# get number of rows that fit on screen
ROWS=$(tput lines)
# caluclate max width and height of image
MAXWIDTH=$(($(($COLUMNSIZE * $COLUMNS)) - $((2 * $PADDING))))
MAXHEIGHT=$(($(($ROWSIZE * $(($ROWS - 2)))) - $((2 * $PADDING)))) # subtract 2 lines to account for prompt

# pass around message for debugging
message=""

#message="$message rows: $ROWS columns: $COLUMNS padding: $PADDING"
#message="$message max width: $MAXWIDTH max height: $MAXHEIGHT"

# get w/h of image
read -r width height <<< $(echo -e "5;$IMAGE" | $BINARY)

# scale image if too large
if test $width -gt $MAXWIDTH; then
    #message="$message\nAdjusted image width. ($width x $height -> "
    height=$(($height * $MAXWIDTH / $width))
    width=$MAXWIDTH
    #message="$message$width x $height)"
fi
if test $height -gt $MAXHEIGHT; then
    #message="$message\nAdjusted image height. ($width x $height -> "
    width=$(($width * $MAXHEIGHT / $height))
    height=$MAXHEIGHT
    #message="$message$width x $height)"
fi

# get display command
# format: <number of images>;<x>;<y>;<width>;<height>;<xoffset>;<yoffset>;<sourcewidth>;<sourceheight><pathtoimage><?><?>
displayCommand="0;1;$PADDING;$PADDING;$width;$height;;;;;$IMAGE\n4;\n3;"

# clear terminal to make room for image
tput clear
# move curser to after image
tput cup $(($height / $ROWSIZE)) 0
#message="$message $(($height / $ROWSIZE))"
# display image using binary
echo -e $displayCommand|$BINARY
echo -e $message

