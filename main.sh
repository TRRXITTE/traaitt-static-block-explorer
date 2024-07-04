#!/bin/bash -e

# static explorer page generator
# by TurtleCoin Team, traaittPlatform 2020

# see LICENSE for details

#!/bin/bash -e

# Static explorer page generator
# by TurtleCoin Team, traaittPlatform 2020
# See LICENSE for details

# Retrieve the current height and adjust for the last block
HEIGHT=$(curl -s http://localhost:14485/getheight | jq '.height')
let "HEIGHT--"

# Function to generate ASCII art header
generate_ascii() {
    cat << "EOF"
||====================================================================||
||////////////////////////////////////////////////////////////////////||
|| 100$ =================| FEDERAL RESERVE NOTE |=============== 100$ ||
|||||                    ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾                  |||||
||<<|    TRRXITTE Int.                                             |>>||
||>>|                          88888888888         T44737133B      |<<||
||<<|                              $$$                             |>>||
||>>|                              888                             |<<||
||<<|      T44737133B              $$$             One Hundred     |>>||
||>>|                                                              |<<||
||<<|      Treasurer     ________________________     Secretary 17 |>>||
|||||                  ~|UNITED STATES OF AMERICA|~                |||||
|| 100$ ==================  ONE HUNDRED traaitt ================ 100$ ||
||////////////////////////////////////////////////////////////////////||
||====================================================================||
traaitt.com cryptonote currency static explorer!
EOF
}

# Function to retrieve current block height
get_current_block() {
    echo -e "\n### CURRENT BLOCK ###"
    curl -s http://localhost:14485/getheight | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'
}

# Function to retrieve last block header
get_last_block_header() {
    echo -e "\n### LAST BLOCK HEADER ###"
    curl -sd '{"jsonrpc":"2.0","method":"getlastblockheader","params":{}}' http://localhost:23896/json_rpc | jq -r .result.block_header | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'
}

# Function to retrieve network information
get_network_info() {
    cat <<EOF
### NETWORK INFO ###
$(curl -s http://localhost:14485/getinfo | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]')
EOF
}

# Function to retrieve pending transactions
get_pending_transactions() {
    echo -e "\n### PENDING TRANSACTIONS ###"
    curl -sd '{"jsonrpc":"2.0","method":"f_on_transactions_pool_json","params":{}}' http://localhost:23896/json_rpc | jq '.result.transactions[]' | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'
}

# Function to retrieve last 10 blocks
get_last_10_blocks() {
    echo -e "\n### LAST 10 BLOCKS ###"
    curl -sd '{"jsonrpc":"2.0","method":"f_blocks_list_json","params":{"height":'"$HEIGHT"'}}' http://localhost:23896/json_rpc | jq '.result.blocks' | jq '.[0:10]'
}

# Include footer
include_footer() {
    cat footer.txt
}

# Generate the HTML content
generate_html() {
    generate_ascii
    get_current_block
    get_last_block_header
    get_network_info
    get_pending_transactions
    get_last_10_blocks
    include_footer
}

# Call function to generate HTML and save it to index.html
generate_html > /home/traaitt/tor/index.html
