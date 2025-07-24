#!/bin/bash
pgrep apache2 > /dev/null || systemctl restart apache2
