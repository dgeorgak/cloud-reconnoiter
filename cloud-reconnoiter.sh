#!/bin/bash

domain=$1
RED="\033[1;31m"
RESET="\033[0m"

if [ ! -d "$domain" ]; then
	mkdir $domain
fi

# Download latest sni-ip ranges from kaeferjaeger
echo -e "${RED} [+] Downloading SNI IPs from kaefetjaeger... ${RESET}this might take a while :|"
echo -e "Amazon"
wget https://kaeferjaeger.gay/sni-ip-ranges/amazon/ipv4_merged_sni.txt -O amazon-ipv4-sni-ip.txt
echo -e "Digital Ocean"
wget https://kaeferjaeger.gay/sni-ip-ranges/digitalocean/ipv4_merged_sni.txt -O DO-ipv4-sni-ip.txt
echo -e "Google"
wget https://kaeferjaeger.gay/sni-ip-ranges/google/ipv4_merged_sni.txt -O google-ipv4-sni-ip.txt
echo -e "Microsoft"
wget https://kaeferjaeger.gay/sni-ip-ranges/microsoft/ipv4_merged_sni.txt -O microsoft-ipv4-sni-ip.txt
echo -e "Oracle"
wget https://kaeferjaeger.gay/sni-ip-ranges/oracle/ipv4_merged_sni.txt -O oracle-ipv4-sni-ip.txt

cat *.txt | grep -F $domain | awk -F '-- ' '{print $2}' | tr ' ' '\n' | tr '[' ' ' | sed 's/ //' | sed 's/\]//' | grep -F $domain | sort -u > $domain/$domain.txt

