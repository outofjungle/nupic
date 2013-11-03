Vagrant.configure('2') do |config|
  config.vm.box = 'opscode-ubuntu-12.04'
  config.vm.box_url = 'https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'
  config.vm.hostname = 'default-ubuntu-1204.vagrantup.com'
  config.vm.provider :virtualbox do |provider|
    provider.customize ['modifyvm', :id, '--memory', '2048']
  end

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe('nupic-cookbook::default')
  end
end