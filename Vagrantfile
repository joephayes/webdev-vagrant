# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-14.04"

#  config.vm.network :forwarded_port, guest: 6379, host: 6379, auto_correct: true
#  config.vm.network :forwarded_port, guest: 27017, host: 27017, auto_correct: true
#  config.vm.network :forwarded_port, guest: 9000, host: 9000, auto_correct: true

  config.vm.network :private_network, ip: "192.168.33.10"

  if Vagrant::Util::Platform.windows?
    config.vm.synced_folder "../vagrant", "/vagrant"
  else
    config.vm.synced_folder "../vagrant", "/vagrant", type: 'nfs'
  end

  config.vm.provider "virtualbox" do |v|
    # Give VM 1/4 system memory
    if Vagrant::Util::Platform.darwin?
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024
    elsif Vagrant::Util::Platform.linux?
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i
    elsif Vagrant::Util::Platform.windows?
      # Windows code via https://github.com/rdsubhas/vagrant-faster
      mem = `wmic computersystem Get TotalPhysicalMemory`.split[1].to_i / 1024
    end

    mem = mem / 1024 / 4
    v.customize ["modifyvm", :id, "--memory", mem]
  end

  config.vm.provision "chef_solo" do |chef|
    chef.custom_config_path = "Vagrantfile.chef"
    chef.add_recipe "apt"
    chef.add_recipe "git"
    chef.add_recipe "nginx"
    chef.add_recipe "nodejs"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv::user"
    chef.add_recipe "vim"

    chef.json = {
        :git     => {
          :prefix => "/usr/local"
        },
        :nginx   => {
          :dir                => "/etc/nginx",
          :log_dir            => "/var/log/nginx",
          :binary             => "/usr/sbin/nginx",
          :user               => "www-data",
          :init_style         => "runit",
          :pid                => "/var/run/nginx.pid",
          :worker_connections => "1024"
        },
        :nodejs => {
          :version => "4.6.0",
          :install_method => "binary",
          :binary => {
            :checksum => "acf08148cecf245f28126122ac9128ff9909f00938b18d80fc0b92648d1c98a8"
          }
        },
        :rbenv => {
          :user_installs => [{
            :user => "vagrant",
            :rubies => ["2.3.1"],
            :global => "2.3.1",
            :gems => {
              "2.3.1" => [
                {:name => "bundler"}
              ]
            }
          }]
        }
      }
  end

  config.vm.provision :shell, :inline => "sudo apt-get update"
  config.vm.provision :shell, :inline => "npm install -g npm"
  config.vm.provision :shell, :inline => "npm install -g yo"
  config.vm.provision :shell, :inline => "npm install -g grunt-cli"
  config.vm.provision :shell, :inline => "npm install -g bower"
  config.vm.provision :shell, :inline => "npm install -g generator-angular-fullstack"
  config.vm.provision :shell, :inline => "npm install -g express"
  config.vm.provision :shell, :inline => "npm install -g node-inspector"
  config.vm.provision :shell, :inline => "npm install -g nodemon"
  config.vm.provision :shell, :inline => "wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh"
  config.vm.provision :shell, :path => "./scripts/redis.sh"
  config.vm.provision :shell, :path => "./scripts/mongodb.sh"
  config.vm.provision :shell, :path => "./scripts/jre.sh"
  config.vm.provision :shell, :path => "./scripts/setup.sh", :run => "always"
end
