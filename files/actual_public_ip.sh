#! /bin/bash
ip=$(wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
echo "actual_public_ip=$ip"
