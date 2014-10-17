#webdev-vagrant

Vagrant config to create web development VM

## Prerequisites

Download and install the following:

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [ChefDK](https://downloads.getchef.com/chef-dk/)

After you have completed the installs, open a command prompt and run the following commands to install the required vagrant plugins:

```bash
$ vagrant plugin install vagrant-omnibus
$ vagrant plugin install vagrant-berkshelf
```

## Running

### Installation

```bash
cd ~
git clone https://github.com/joephayes/webdev-vagrant.git
mkdir vagrant # shared folder. If you want to change it, edit the Vagrantfile
```

To start the VM change directory to the directory where you cloned the repo and run the following command

```bash
$ vagrant up
```


