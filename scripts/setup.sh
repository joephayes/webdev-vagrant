set -e

vagrantpath=$(su - vagrant -c env | grep ^PATH= | cut -d'=' -f2-);
npm_bin_path=$(npm bin -g);

if ! [[ :$vagrantpath: == *:"$npm_bin_path":* ]] ; then
  echo "export PATH=$npm_bin_path:\$PATH" >> /home/vagrant/.profile
fi

