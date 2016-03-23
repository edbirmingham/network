VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/ubuntu-14.04"

  config.ssh.forward_agent = true
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.synced_folder '.', '/vagrant', nfs: true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.add_recipe :apt
    chef.add_recipe 'nodejs'
    chef.add_recipe 'mongodb::default'
    chef.json = {
      :mongodb => {
        :dbpath  => "/var/lib/mongodb",
        :logpath => "/var/log/mongodb",
        :port    => "27017"
      }
    }
    chef.add_recipe :git
  end

  $script = <<-SCRIPT
  echo ""
  echo "============================================="
  echo ""
  echo "          Installing Node.js Packages..."
  echo ""
  echo "============================================="
  echo ""
  npm install -g bower
  npm install -g gulp
  npm install -g grunt
  npm install -g grunt-cli
  npm install -g yo
  npm install -g generator-meanjs
  su - vagrant -c "cd /vagrant && npm install"
  echo ""
  echo "============================================="
  echo ""
  echo "   Finished Installing Node.js Packages..."
  echo ""
  echo "============================================="
  if [ ! -f /home/vagrant/.bash_profile ]; then
    echo "cd /vagrant" >> /home/vagrant/.bash_profile
  fi
  echo ""
  SCRIPT
  config.vm.provision 'shell', inline: $script

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |v|
    host = RbConfig::CONFIG['host_os']

    # Give VM 1/4 system memory & access to all cpu cores on the host
    if host =~ /darwin/
      cpus = `sysctl -n hw.ncpu`.to_i
      # sysctl returns Bytes and we need to convert to MB
      mem = `sysctl -n hw.memsize`.to_i / 1024 / 1024 / 4
    elsif host =~ /linux/
      cpus = `nproc`.to_i
      # meminfo shows KB and we need to convert to MB
      mem = `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / 1024 / 4
    else # sorry Windows folks, I can't help you
      cpus = 2
      mem = 1024
    end

    v.customize ["modifyvm", :id, "--memory", mem]
    v.customize ["modifyvm", :id, "--cpus", cpus]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # Fix problem with time on VM getting out of sync with host.
    v.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000 ]
  end
end
