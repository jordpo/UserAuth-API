# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise64'

  config.vm.synced_folder '.', '/vagrant/', type: 'nfs'

  config.vm.network :private_network, ip: '10.10.10.60'
  config.vm.network :forwarded_port, guest: 3000, host: 3060

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024']
  end

  config.vm.provision :shell, path: 'https://github.com/AgilionApps/VagrantDevEnv/raw/v0.3.5/scripts/base.sh'
  config.vm.provision :shell, privileged: false, path: 'https://raw.githubusercontent.com/AgilionApps/VagrantDevEnv/v0.3.6/scripts/ruby-2.2.0.sh'
  config.vm.provision :shell, path: 'https://github.com/AgilionApps/VagrantDevEnv/raw/v0.3.5/scripts/postgresql93.sh'
  config.vm.provision :shell, path: 'https://github.com/AgilionApps/VagrantDevEnv/raw/v0.3.5/scripts/elasticsearch-1.4.0.sh'
end
