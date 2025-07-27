#!/bin/bash

# Import add hosts function
source "$(pwd)/addhosts.sh"

# Initial setup
echo "Welcome to 0xleaf's b0xinit!"
read -rp "Please input the project's name: " project_name

echo -e "Creating $(pwd)/$project_name...\n"
mkdir -p "$(pwd)/$project_name"

# Create IP database
echo -e "Creating IP list at $project_name/ips.txt...\n"
touch "$(pwd)/$project_name/ips.txt"

# Create init for easy loading of data later
echo "Creating init file at $project_name/init.sh..."
touch "$(pwd)/$project_name/init.sh"
echo "#!/bin/bash" > "$(pwd)/$project_name/init.sh"
echo "" >> "$(pwd)/$project_name/init.sh"
echo -e "init.sh created.\n"

# Input domain
read -rp "Input domain (optional): " domain

if [[ -n $domain ]]; then
    echo "export d=$domain" >> "$(pwd)/$project_name/init.sh"
    echo -e "Adding domain to init.sh. Invoking the variable '\$d' will now output the domain name.\n"
fi

# Run addhosts function
add_hosts

# Prompt user to add credentials
read -rp "Do you want to add credentials? [y/N] " creds
creds=${creds:-N} # Set N for default

if [[ "${creds^^}" != "N" ]]; then
    # Add addcreds to source for its function
    source "$(pwd)/addcreds.sh"
    add_creds
fi

. "$(pwd)/$project_name/init.sh"
echo "Init complete! Don't forget to source the file for use with 'source "$(pwd)/$project_name/init.sh"' to work with the variables."
echo "Happy hacking! :)"