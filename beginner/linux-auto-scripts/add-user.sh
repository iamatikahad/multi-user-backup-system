#!/bin/bash
read -p "Enter username: " user
useradd -m "$user" && echo "User $user added."
