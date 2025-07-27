# b0xinit

A script to handle data management of pentesting lab boxes. Currently very rudimentary and can be considered a prototype.

## Features:
- Automatic creation of project folders
- Map each hosts' hostnames and IPs
- Add credentials to a single file
- Easy IP and password recall (no need to swap windows to your Notes app anymore, just use the variables 
\$\<HOSTNAME> and \$\<USERNAME> to get their passwords!)
- Automatic nmap scans for each IP

## To-do:
- Port over to python for more flexibility
- Auto-parse nmap scan logs
- Automate other tools based on nmap log (e.g. gobuster for port 80/443)

## Installation

Clone the repo directly with:
```
git clone https://github.com/0xleaf/b0xinit.git
```

## Usage

```
cd b0xinit/
chmod +x b0xinit.sh
./b0xinit.sh
```

You can also add more hosts and creds via their respective script:
```
chmod +x addhosts.sh
./addhosts.sh
```

```
chmod +x addcreds.sh
./addcreds.sh
```