#!/bin/bash

# Function to print password expiration for a single user
check_user() {
    local username=$1
    local expiration_date=$(az vm run-command invoke --resource-group devvmlab0_group --name devvmlab0_group --command-id RunShellScript --scripts "/usr/sbin/chage -l $username | grep 'Password expires' | awk -F': ' '{print \$2}'")
    echo "Password expiration for user $username: $expiration_date"
}

# Check password expiration for each user provided as argument
for username in "$@"; do
    check_user $username
done
