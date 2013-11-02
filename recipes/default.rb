#
# Cookbook Name:: nupic
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

#package 'freetype-devel'

include_recipe 'apt'
include_recipe 'python'

template '/home/vagrant/.bashrc' do
  source 'bashrc.erb'
  owner 'vagrant'
  group 'vagrant'
  mode 00644
  variables({
     :home_dir => '/home/vagrant',
     :nupic_repo => '/tmp/nupic-master'
  })
end

package 'libfreetype6-dev'
package 'libpng12-dev'
package 'libtool'
package 'automake'
package 'build-essential'

python_pip 'numpy' do
  version '1.7.1'
  action :install
end

python_pip 'matplotlib' do
  version '1.1.0'
  action :install
end

python_pip 'asteval' do
  version '0.9.1'
  action :install
end


python_pip 'mock' do
  version '1.0.1'
  action :install
end

python_pip 'ordereddict' do
  version '1.1'
  action :install
end

python_pip 'PIL' do
  version '1.1.7'
  action :install
end

python_pip 'psutil' do
  version '1.0.1'
  action :install
end

python_pip 'pylint' do
  version '0.28.0'
  action :install
end

python_pip 'pytest' do
  version '2.4.2'
  action :install
end

python_pip 'pytest-cov' do
  version '1.6'
  action :install
end

python_pip 'pytest-xdist' do
  version '1.8'
  action :install
end

python_pip 'python-dateutil' do
  version '2.1'
  action :install
end

python_pip 'PyYAML' do
  version '3.10'
  action :install
end

python_pip 'unittest2' do
  version '0.5.1'
  action :install
end

python_pip 'validictory' do
  version '0.9.1'
  action :install
end

python_pip 'PyMySQL' do
  version '0.5'
  action :install
end

python_pip 'DBUtils' do
  version '1.1'
  action :install
end

python_pip 'tweepy' do
  version '2.1'
  action :install
end

remote_file '/tmp/nupic.tar.gz' do 
  source 'https://github.com/numenta/nupic/archive/master.tar.gz'
  checksum '0c10e00cb2a8b3c86050c6c04013f3096f6c4892c32700cfa0bfc96629e812d1'
  mode 00666
end

execute 'untar nupic' do
  command 'tar -xzf /tmp/nupic.tar.gz -C /tmp'
  user 'vagrant'
  not_if { ::File.exists?('/tmp/nupic-master/README.md') }
end

execute 'build nupic' do
  command '/tmp/nupic-master/build.sh'
  user 'vagrant'
  environment ({
    'HOME' => '/home/vagrant',
    'NTA' => '/home/vagrant/nta/eng',
    'NUPIC' => '/tmp/nupic-master',
    'BUILDDIR' => '/tmp/ntabuild',
    'MK_JOBS' => '3'
  })
end
