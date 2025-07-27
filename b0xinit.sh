#!/bin/bash

# Import add hosts function
source $(pwd)/addhosts.sh

# Initial setup
echo "Welcome to 0xleaf's b0xinit!"
read -rp "Please input the project's name: " project_name

echo -e "Creating $(pwd)/$project_name...\n"
mkdir $(pwd)/$project_name

# Create init for easy loading of data later
echo "Creating init file at $project_name/init.sh..."
touch $(pwd)/$project_name/init.sh
echo "#!/bin/bash" > $(pwd)/$project_name/init.sh
echo "" >> $(pwd)/$project_name/init.sh
echo -e "init.sh created. Load the file for subsequent use with 'source $(pwd)/$project_name/init.sh'\n"

# Input domain
read -rp "Input domain (optional): " domain

if [[ -n $domain ]]; then
    echo "export d=$domain" >> $(pwd)/$project_name/init.sh
    echo -e "Adding domain to init.sh. Invoking the variable '\$d' will now output the domain name.\n"
fi

# Input hosts
read -rp "Number of hosts: " num_hosts
echo -e "Creating IP list at $project_name/ips.txt...\n"
touch $(pwd)/$project_name/ips.txt

# Prompt user for nmap
read -rp "Do you want to run nmap for each hosts? [y/N] " nmap
nmap={nmap:-N} # Set N for default

if [[ {$nmap^^} != "N" ]]; then
    echo -e "nmap scan logs will be generated at $project_name/<HOSTNAME>/nmap.log.\n"
fi

# Iterate add_hosts for each host
for ((i = 1; i <= num_hosts; i++)); do
    add_hosts
done

# Prompt user to add credentials
read -rp "Do you want to add credentials? [y/N] " creds
creds={creds:-N}

if [[ {$creds^^} != "N" ]]; then
    # Add addcreds to source for its function
    source $(pwd)/addcreds.sh
    add_creds
fi

. $(pwd)/$project_name/init.sh
echo "Init complete! Happy hacking :)"