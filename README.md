# NuPIC cookbook

Chef cookbook that bootstraps Numenta's [NuPIC](http://numenta.org/nupic.html) platform. 

# Requirements

1. [VirtualBox](https://www.virtualbox.org)
2. [Vagrant](http://www.vagrantup.com/)
3. [Bundler](http://bundler.io/)

# Usage

Use vagrant or test-kitchen to create NuPIC VM.

For Vagrant:

1. Install `vagrant-berkshelf`
2. Check out this cookbook
3. `bundle install` and `berks install` in this directory
4. Run `vagrant up` to create a Ubuntu virtual machine with nupic for `default['nupic']['user']` user

```
vagrant plugin install vagrant-berkshelf
git clone git@github.com:outofjungle/nupic-cookbook.git
cd nupic-cookbook
bundle install
berks install
vagrant up
```

For test-kitchen:

1. Check out this cookbook
2. `bundle install` and `berks install` in this directory
3. Run `kitchen create` to create a Ubuntu virtual machine
4. Run `kitchen converge` to install all nupic dependencies and nupic for `default['nupic']['user']` user

```
git clone git@github.com:outofjungle/nupic-cookbook.git
cd nupic-cookbook
bundle install
berks install
kitchen create && kitchen converge
```

# Attributes

The default attributes install nupic for the user `vagrant`. The default user can be overridden by changing the default attributes file.

NuPIC repository url and branch

```
default['nupic']['git']['url'] = 'https://github.com/numenta/nupic.git'
default['nupic']['git']['branch'] = 'master'
```

User for which NuPIC will be installed

```
default['nupic']['user'] = 'vagrant'
default['nupic']['group'] = 'vagrant'
default['nupic']['user']['homedir'] = '/home/vagrant'
```

# Author

Venkat Venkataraju (venkat.venkataraju@yahoo.com)


