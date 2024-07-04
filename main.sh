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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRRXITTE Static Explorer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .ascii-art {
            white-space: pre;
            font-family: monospace;
            font-size: 14px;
            line-height: 1.4;
            margin-bottom: 20px;
            color: #333;
        }
        .section {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #ccc;
        }
        .section h3 {
            font-size: 18px;
            margin-top: 0;
            padding-top: 0;
            color: #444;
        }
        .section pre {
            white-space: pre-wrap;
            font-family: monospace;
            font-size: 14px;
            line-height: 1.4;
            margin-top: 8px;
            background-color: #f8f8f8;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="ascii-art">
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
        </div>
EOF
}

# Function to retrieve current block height
get_current_block() {
    echo -e "<div class=\"section\">
        <h3>CURRENT BLOCK</h3>"
    curl -s http://localhost:14485/getheight | jq -r 'to_entries|map("<pre>\(.key) - \(.value|tostring)</pre>")|.[]'
    echo "</div>"
}

# Function to retrieve last block header
get_last_block_header() {
    echo -e "<div class=\"section\">
        <h3>LAST BLOCK HEADER</h3>"
    curl -sd '{"jsonrpc":"2.0","method":"getlastblockheader","params":{}}' http://localhost:23896/json_rpc | jq -r .result.block_header | jq -r 'to_entries|map("<pre>\(.key) - \(.value|tostring)</pre>")|.[]'
    echo "</div>"
}

# Function to retrieve network information
get_network_info() {
    echo -e "<div class=\"section\">
        <h3>NETWORK INFO</h3>"
    curl -s http://localhost:14485/getinfo | jq -r 'to_entries|map("<pre>\(.key) - \(.value|tostring)</pre>")|.[]'
    echo "</div>"
}

# Function to retrieve pending transactions
get_pending_transactions() {
    echo -e "<div class=\"section\">
        <h3>PENDING TRANSACTIONS</h3>"
    curl -sd '{"jsonrpc":"2.0","method":"f_on_transactions_pool_json","params":{}}' http://localhost:23896/json_rpc | jq '.result.transactions[]' | jq -r 'to_entries|map("<pre>\(.key) - \(.value|tostring)</pre>")|.[]'
    echo "</div>"
}

# Function to retrieve last 10 blocks
get_last_10_blocks() {
    echo -e "<div class=\"section\">
        <h3>LAST 10 BLOCKS</h3>"
    curl -sd '{"jsonrpc":"2.0","method":"f_blocks_list_json","params":{"height":'"$HEIGHT"'}}' http://localhost:23896/json_rpc | jq '.result.blocks' | jq '.[0:10]' | jq -r 'map("<pre>\(.)</pre>")|.[]'
    echo "</div>"
}

# Include footer
include_footer() {
    cat << "EOF"
    </div>
</body>
</html>
EOF
}


