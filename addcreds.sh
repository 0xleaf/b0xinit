#!/bin/bash

# Function to add credentials to database
add_creds() {
    export loop="Y"
    
    while [[ "${loop^^}" != "N" ]]; do
        read -rp "Username: " username
        read -rp "Password/Hash: " password

        echo "$username:$password" >> "$(pwd)/$project_name/credentials.txt"
        echo "export $username=$password" >> "$(pwd)/$project_name/init.sh"

        read -rp "Do you want to add more? [y/N]" loop
        loop=${loop:-N}
    done

    echo -e "Done writing data! Credentials are saved in $project_name/credentials.txt.\n"
    echo "Additionally, invoking the variable '\$<USERNAME>' will now output the user's password/hash."
}

# If script is being executed directly
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    # Prompt for project name
    echo -e "addcreds.sh // Script to add credentials to the database\n"
    read -rp "Please enter the project's name: " project_name
    add_creds
fi