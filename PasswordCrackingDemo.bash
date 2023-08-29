#!/bin/bash

# Define the file where the hashes will be stored
output_file="MD5_list.txt"

# Clear the output file before appending new hashes
> $output_file

# Loop to continue receiving input
while true; do
  echo "Please enter a password (or type 'exit' to finish):"

  # Read the input with hidden characters
  read -s input_password

  # Check if the user wants to exit
  if [ "$input_password" == "exit" ]; then
    break
  fi

  # Hash the input using MD5 and append to the output file
  echo -n "$input_password" | md5sum | awk '{ print $1 }' >> $output_file

  echo "Password has been hashed and added to the list!"
done

echo "Password MD5 Hash List Complete"

# Prompt to check if the user is ready to start Hashcat
while true; do
  echo "Are you ready to start the Hashcat cracking process? (y/n)"
  read -r start_hashcat

  if [ "$start_hashcat" == "y" ]; then
    echo "Starting the Hashcat cracking process..."
    hashcat --potfile-disable -m 0 $output_file /usr/share/seclists/Passwords/xato-net-10-million-passwords-1000000.txt
    echo "Done!"
    break
  elif [ "$start_hashcat" == "n" ]; then
    echo "Exiting without running Hashcat."
    break
  else
    echo "Invalid input. Please enter 'y' for yes or 'n' for no."
  fi
done
