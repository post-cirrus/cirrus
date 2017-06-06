#!/bin/bash
# Block specific IP Address to access FB
# Usage block_twitter.sh <IP-Address>

if [ $# -eq 0 ]
  then
    printf "\n No arguments supplied,  Usage ->  ./block_twitter.sh <IP-Address> \n\n"
    
  else
    /usr/bin/whois -h "whois.radb.net" -- '-i origin AS13414' | egrep "^route:" | awk '{print $NF}' | sed -r 's/(.*)/iptables -t filter -I FORWARD -s $1\/32 -d \1 -j REJECT/' |
 source /dev/stdin
fi
