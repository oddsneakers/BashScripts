#!/bin/bash
# This is designed to work along side IPextract.bash

# Check if nmap is installed
if ! command -v nmap &> /dev/null
then
    echo "nmap could not be found, please install it first."
    exit 1
fi

# Base directory for storing results
base_dir="nmap_scan_results"
mkdir -p "$base_dir"

# Read each IP address from IPresults.txt
while IFS= read -r ip; do
    echo "Starting scans for $ip..."

    # Directory for this IP's scan results
    ip_dir="$base_dir/$ip"
    mkdir -p "$ip_dir"

    # Define different types of nmap scans
    declare -A scans
    scans["basic_scan"]="nmap $ip"
    scans["os_detection"]="nmap -O $ip"
    scans["version_detection"]="nmap -sV $ip"
    scans["aggressive_scan"]="nmap -A $ip"
    scans["udp_scan"]="nmap -sU $ip"
    scans["vuln_scan"]="nmap --script=vuln $ip"
    scans["smb_scan"]="nmap --script=smb-enum-shares,smb-enum-users $ip"
    scans["http_enum"]="nmap --script=http-enum $ip"
    scans["ssl_scan"]="nmap --script=ssl-cert,ssl-enum-ciphers $ip"
    scans["dns_brute"]="nmap --script=dns-brute $ip"

    # Execute each scan and save the results
    for scan_name in "${!scans[@]}"; do
        echo "Performing $scan_name on $ip..."
        scan_result_file="$ip_dir/${scan_name}.txt"
        ${scans[$scan_name]} > "$scan_result_file"
    done

    echo "Scans completed for $ip."
done < "IPresults.txt"

echo "All scans are completed."
