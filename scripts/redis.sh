cd;
wget http://download.redis.io/redis-stable.tar.gz;
tar xvzf redis-stable.tar.gz;
cd redis-stable;
make;
make install;
echo -n | utils/install_server.sh;

