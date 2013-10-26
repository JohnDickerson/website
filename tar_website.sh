#!/bin/bash

# (1)  Have the site served at port 9292 (e.g., rackup -p 9292)
# (2)  Run this script from the root directory of website
# (3)  This script HTTrack-rips from index.html, stores in ../website_backup

backup_path="../website_backup"
rm -rf ${backup_path}
httrack "http://127.0.0.1:9292/" -O ${backup_path}
tar cvfz ${backup_path}.tgz ${backup_path}

