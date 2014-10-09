#
# Author:: Venkat Venkataraju (<venkat.venkataraju@yahoo.com>)
# Copyright (C) 2013 Venkat Venkataraju
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Cookbook Name:: nupic-cookbook
# Recipe:: default
#

include_recipe 'apt'
include_recipe 'python'

template "#{node['nupic']['user']['homedir']}/.bashrc" do
  source 'bashrc.erb'
  owner node['nupic']['user']['username']
  group node['nupic']['user']['group']
  mode 00644
  variables({
     :home_dir => "#{node['nupic']['user']['homedir']}",
     :nupic_repo => '/tmp/nupic'
  })
end

packages = %w(git python-dev python-pip automake libtool libssl-dev g++ cmake mysql-server)

packages.each do | pkg |
  package pkg
end

python_pacakges = {
  'asteval' => '0.9.1',
  'mock' => '1.0.1',
  'ordereddict' => '1.1',
  'pillow' => '2.3.0',
  'psutil' => '1.0.1',
  'pylint' => '1.1.0',
  'pytest' => '2.4.2',
  'pytest-cov' => '1.6',
  'pytest-xdist' => '1.8',
  'python-dateutil' => '2.1',
  'PyYAML' => '3.10',
  'unittest2' => '0.5.1',
  'validictory' => '0.9.1',
  'PyMySQL' => '0.6.2',
  'DBUtils' => '1.1',
  'numpy' => '1.7.1',
  'tweepy' => '2.1',
  'pyproj' => '1.9.3',
  'prettytable' => '0.7.2'
}

python_pacakges.each do | package_name, package_version |
  python_pip package_name do
    version package_version
    action :install
  end
end

git '/tmp/nupic' do
  repository node['nupic']['git']['url']
  revision node['nupic']['git']['branch']
  action :sync
  user node['nupic']['user']['username']
  group node['nupic']['user']['group']
  # notifies :run, 'execute[build nupic]'
end

execute 'build nupic' do
  command 'cd /tmp/nupic && python setup.py install'
  user node['nupic']['user']['username']
  group node['nupic']['user']['group']
  environment ({
    'HOME' => "#{node['nupic']['user']['homedir']}",
    'NTA' => "#{node['nupic']['user']['homedir']}/nta/eng",
    'NUPIC' => '/tmp/nupic',
    'BUILDDIR' => '/tmp/ntabuild',
    'MK_JOBS' => '3'
  })
  # action :nothing
end

# export HOME="/home/vagrant"
# export NTA="/home/vagrant/nta/eng"
# export NUPIC="/tmp/nupic"
# export BUILDDIR="/tmp/ntabuild"
# export MK_JOBS="3"
