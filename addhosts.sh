#!/bin/bash

# Function for adding hosts to database
add_hosts() {
    # Input hosts
    read -rp "Number of hosts: " num_hosts

    # Prompt user for nmap
    read -rp "Do you want to run nmap for each hosts? [y/N] " nmap
    nmap=${nmap:-N} # Set N for default

    if [[ "${nmap^^}" != "N" ]]; then
        echo -e "nmap scan logs will be generated at $project_name/<HOSTNAME>/nmap.log.\n"
    fi

    # Iterate add_hosts for each host
    for ((i = 1; i <= num_hosts; i++)); do
        read -rp "Host $i's IP: " ip
        read -rp "Host $i's hostname: " hostname

        # Create working directory for each host
        mkdir "$(pwd)/$project_name/$hostname"
        echo "Adding IP to ips.txt..."
        echo "$ip" >> "$(pwd)/$project_name/ips.txt"
        
        # Export IPs for easy calling with hostname to init
        echo -e "Adding hostname:IP pair to init.sh. Invoking the variable '\$$hostname' will now output its IP.\n"
        echo "export $hostname=$ip" >> "$(pwd)/$project_name/init.sh"

        if [[ "${nmap^^}" != "N" ]]; then
            echo -e "Running nmap scan...\n"
            nmap -sV -sC -vv -T4 -oN "$(pwd)/$project_name/$hostname/nmap.log"
        fi
    done
    
}

# If script is being executed directly
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    # Prompt for project name

    echo -e "addhosts.sh // Script to add hosts to a project\n"
    read -rp "Please enter the project's name: " project_name
    add_hosts
fi