!/bin/bash

# This script will run 2 individual arp scans and create 2 .txt files containing lists of the IP addresses found. 
# IPresults.txt contains a basic list suitable for nmap scans
# IPresults_nessus.txt contains a list with a comma seperating each IP address, suitable to be copied into Nessus.


# Run arp-scan, remove the firstlines (contained "interface:"), then extract only the IP addresses
sudo arp-scan -l | sed '1,2d' | awk '/([0-9]{1,3}\.){3}[0-9]{1,3}/{print $1}' > IPresults.txt

# Run arp-scan, remove the firstlines (contained "interface:"), then extract only the IP addresses
sudo arp-scan -l | sed '1,2d' | awk '/([0-9]{1,3}\.){3}[0-9]{1,3}/{print $1","}' > IPresults_nessus.txt

# Remove the trailing comma from the list
sed -i '$ s/,$//' IPresults_nessus.txt
