#
# Cookbook Name:: nupic
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'python'

template '/home/vagrant/.bashrc' do
  source 'bashrc.erb'
  owner node['nupic']['user']
  group node['nupic']['group']
  mode 00644
  variables({
     :home_dir => '/home/vagrant',
     :nupic_repo => '/tmp/nupic'
  })
end

package 'libfreetype6-dev'
package 'libpng12-dev'
package 'libtool'
package 'automake'
package 'build-essential'
package 'git'

python_pacakges = {
  'numpy' => '1.8.0',
  'matplotlib' => '1.1.0',
  'asteval' => '0.9.1',
  'mock' => '1.0.1',
  'ordereddict' => '1.1',
  'PIL' => '1.1.7',
  'psutil' => '1.0.1',
  'pylint' => '0.28.0',
  'pytest' => '2.4.2',
  'pytest-cov' => '1.6',
  'pytest-xdist' => '1.8',
  'python-dateutil' => '2.1',
  'PyYAML' => '3.10',
  'unittest2' => '0.5.1',
  'validictory' => '0.9.1',
  'PyMySQL' => '0.5',
  'DBUtils' => '1.1',
  'tweepy' => '2.1'
}

python_pacakges.each do | package_name, package_version |
  python_pip package_name do
    version package_version
    action :install
  end
end

git '/tmp/nupic' do
  repository 'https://github.com/numenta/nupic.git'
  action :sync
  user node['nupic']['user']
  group node['nupic']['group']
  notifies :run, 'execute[build nupic]'
end

execute 'build nupic' do
  command '/tmp/nupic/cleanbuild.sh'
  user node['nupic']['user']
  group node['nupic']['group']
  environment ({
    'HOME' => '/home/vagrant',
    'NTA' => '/home/vagrant/nta/eng',
    'NUPIC' => '/tmp/nupic',
    'BUILDDIR' => '/tmp/ntabuild',
    'MK_JOBS' => '3'
  })
  action :nothing
end
