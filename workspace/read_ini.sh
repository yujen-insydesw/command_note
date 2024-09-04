#!/bin/bash

# Function to read an INI file
read_ini_file() {
    local filename="$1"
    local section=""
    while IFS=' = ' read -r key value; do
        if [[ $key =~ ^\[(.*)\]$ ]]; then
            section="${BASH_REMATCH[1]}"
        elif [[ $key && $value ]]; then
            key=$(echo $key | tr -d ' ')
            value=$(echo $value | tr -d ' ')
            eval "${section}_${key}='${value}'"
        fi
    done < "$filename"
}

# Main

# config.ini
# [main]
# description = Sample configuration
# timeout = 10
# monitoring_interval = 20
# 
# [database]
# server = db.example.org
# port = 3306
# username = dbuser
# password = dbpass

ini_file="config.ini"
read_ini_file $ini_file

# Accessing the values
echo "Description: $main_description"
echo "Timeout: $main_timeout"
echo "Monitoring Interval: $main_monitoring_interval"
echo "Database Server: $database_server"
echo "Database Port: $database_port"
echo "Database Username: $database_username"
echo "Database Password: $database_password"
