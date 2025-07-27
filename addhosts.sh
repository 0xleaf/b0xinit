#!/bin/bash

# Function for adding hosts to database
add_hosts() {
    read -rp "Host $i's IP: " ip
    read -rp "Host $i's hostname: " hostname

    # Create working directory for each host
    mkdir $(pwd)/$project_name/$hostname
    echo "Adding IP to ips.txt..."
    echo "$ip" >> $(pwd)/$project_name/ips.txt
    
    # Export IPs for easy calling with hostname to init
    echo -e "Adding hostname:IP pair to init.sh. Invoking the variable '\$$hostname' will now output its IP.\n"
    echo "export $hostname=$ip" >> $(pwd)/$project_name/init.sh

    if [[ {$nmap^^} != "N" ]]; then
        echo -e "Running nmap scan...\n"
        nmap -sV -sC -vv -T4 -oN $(pwd)/$project_name/$hostname/nmap.log
    fi
}

# Prompt for project name

echo -e "addhosts.sh // Script to add credentials to a project\n"
read -rp "Please enter the project's name: " project_name

add_hosts