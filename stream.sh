#!/bin/bash

# Exit if any error
set -e

url="https://1337x.to"
query=$(printf '%s' "$*" | tr ' ' '+' )
query_result=$(curl -s $url/search/$query/1/)

# Find all the movies torrent links
movies=$(echo $query_result | \
            grep -oE "torrent\/[0-9]{7}\/[a-zA-Z0-9?%-]*/")
# debug print
# echo "$movies"

# Find all the movies seed counts
seeds=$(echo $query_result | \
            grep -oE "coll-[0-9]\sseeds..[0-9]+" | \
            grep -oE ">[0-9]+" | \
            grep -oE "[0-9]+")
# debug rpint
# echo "$seeds"

movies_count=$(echo "$movies" | wc -l)
seeds_count=$(echo "$seeds" | wc -l)

# Check we got the same number of string. If the number is not the same
# we done something wrong here. 
if [ "$movies_count" -ne "$seeds_count" ]; then
  echo "The counts are different."
  exit 1
fi

# Combine the seeds and movies link together
combined=$(paste -d' ' <(echo "$seeds") <(echo "$movies"))
# debug print
# echo "$combined"

# Get user selection
selected=$(echo "$combined" | fzf)
# debug print
# echo $selected

# Assemble magnet page url
magnet_page_url="$url/$(echo "$selected" | grep -oE "torrent\/[0-9]{7}\/[a-zA-Z0-9?%-]*/")"
# debug print
# echo $magnet_page_url

# Extract magnet url from the page
magnet_page=$(curl -s $magnet_page_url)
magnet_url=$(echo $magnet_page |
              grep -oP "magnet:\?xt=urn:btih:[a-zA-Z0-9&=%\-+\.]*" |
              head -n 1)
# debug print
# echo $magnet_url

# Stream movies
webtorrent $magnet_url --mpv

# Delete the downloaded files when done, we don't want to fill up the tmp folder
 rm -rf /tmp/webtorrent




