# static-block-explorer

A simple static summary of the current and previous X blocks on the ETRX Network. Use this script to generate a static page for use on TOR or other networks where Javascript is not practical.

## Usage:

You will need a fully synced daemon running with the detailed block explorer output enabled.

#### Daemon:

```shell
XTEnetwork --enable-blockexplorer --enable-blockexplorer-detailed
```

```
y66euagdhzaumt5jhftidvd3gaml57glzcvycmdzrydth2kvrverh6ad.onion
```

This script will loop every 30 seconds, querying the daemon for results and writing a static file to the location of the Onion site you're hosting.

_Path and sleep time should be adjusted to match your preferences. The number of blocks you display can also be adjusted up to 144 by changing the last curl statement in `main.sh` to a different value ranging from `[0:0]` to `[0:144]`_

#### Shell:

```bash
sudo bash -c 'while true; do ./main.sh > /home/traaitt/tor/index.html && sleep 23; done'
```

## Example Output:

```bash
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

### CURRENT BLOCK ###
height - 577987
network_height - 577987
status - OK

### LAST BLOCK HEADER ###
### NETWORK INFO ###
alt_blocks_count - 1
difficulty - 63750700
grey_peerlist_size - 39
hashrate - 1416682
height - 577987
incoming_connections_count - 8
last_known_block_index - 577984
major_version - 6
minor_version - 0
network_height - 577987
outgoing_connections_count - 6

outgoing_connections_count - 6
start_time - 1720046818
status - OK
supported_height - 100000000
synced - true
tx_count - 367670
tx_pool_size - 0
upgrade_heights - [1,440000,800000,1000000,100000000]
version - 0.10.45
white_peerlist_size - 9

### PENDING TRANSACTIONS ###

### LAST 10 BLOCKS ###


TRRXITTE Int., incorporate (c) 2024