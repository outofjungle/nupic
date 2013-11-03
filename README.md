# NuPIC cookbook

Chef cookbook that bootstraps Numenta's NuPIC framework. 

# Requirements

1. [VirtualBox](https://www.virtualbox.org)
2. [Vagrant](http://www.vagrantup.com/)
3. [Bundler](http://bundler.io/)

# Usage

1. Check out this cookbook
2. `bundle install` and `berks install` in this directory
3. Run `kitchen create` to create a Ubuntu virtual machine
4. Run `kitchen converge` to install all nupic dependencies and nupic for `vagrant` user

```
git clone git@github.com:outofjungle/nupic-cookbook.git
cd nupic-cookbook
bundle install
berks install
kitchen create && kitchen converge
```
# Author

Venkat Venkataraju (venkat.venkataraju at yahoo dot com)
