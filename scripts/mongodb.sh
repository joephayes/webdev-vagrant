#Step 1: Import the MongoDB public key
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
#Step 2: Generate a file with the MongoDB repository url
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
#Step 3: Refresh the local database with the packages
sudo apt-get update
#Step 4: Install the last stable MongoDB version and all the necessary packages on our system
sudo apt-get install -y mongodb-org
sed -i 's/#port = 27017/port = 27017/' /etc/mongod.conf
sed -i 's/bind_ip = 127.0.0.1/bind_ip = 0.0.0.0/' /etc/mongod.conf
