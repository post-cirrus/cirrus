#!/bin/bash
# Block specific IP Address to access FB and unblock after X seconds
# Usage block_unblock_facebook.sh <IP-Address> <seconds>

if [ $# -eq 0 ]
  then
    printf "\n No arguments supplied,  Usage ->  ./block_unblock_facebook.sh <IP-Address> <seconds> \n\n"
    
  else
    echo "Blocking FB"
    /usr/bin/whois -h "whois.radb.net" -- '-i origin AS32934' | egrep "^route:" | awk '{print $NF}' | sed -r 's/(.*)/iptables -t filter -I FORWARD -s $1\/32 -d \1 -j REJECT/' |
 source /dev/stdin
    echo "Blocked, now sleeping $2 seconds and unblock FB" 
    sleep $2
    iptables --flush
    echo "FB Unblocked"
fi
