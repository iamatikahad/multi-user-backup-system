#!/bin/bash
log() { echo "$(date) [$1] $2" >> /var/log/custom-script.log; }