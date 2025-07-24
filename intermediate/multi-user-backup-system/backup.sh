#!/bin/bash
DATE=$(date +%F)
tar -czf /backup/users/$DATE-home.tar.gz /home
find /backup/users -type f -mtime +7 -delete