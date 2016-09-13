#!/bin/bash

set -e

# Step 1: Import the MongoDB public key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
# Step 2: Generate a file with the MongoDB repository url
echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
# Step 3: Refresh the local database with the packages
sudo apt-get -yqq update
# Step 4: Install the last stable MongoDB version and all the necessary packages on our system
sudo apt-get install -y mongodb-org
# Step 5: Modify the mongod.conf file
sudo service mongod stop
sed -i 's/#port: 27017/port: 27017/' /etc/mongod.conf
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
sudo service mongod start
