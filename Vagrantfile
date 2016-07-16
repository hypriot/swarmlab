# -*- mode: ruby -*-
# vi: set ft=ruby :

# per default the Swarmlab starts with three nodes
# a different number of nodes can be provided with the
# NUMBER_OF_NODES environment variable

number_of_nodes = ENV['NUMBER_OF_NODES'] || 3

Vagrant.configure(2) do |config|

  config.vm.network "private_network", type: "dhcp"

  (1..number_of_nodes).each do |node_number|
    config.vm.define "node#{node_number}" do |node|
      node.vm.box = "ubuntu/wily64"
      node.vm.hostname = "node#{node_number}"
    end
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.linked_clone = true if Vagrant::VERSION =~ /^1.8/
  end

  config.vm.provision "shell", keep_color: true, path: "setup_swarmlab.sh"
end
