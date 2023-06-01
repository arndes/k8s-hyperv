# -*- mode: ruby -*-
# vi: set ft=ruby :

gateway = "10.99.0.1"

masters = {
  "k8s-m01" => { :ip => "10.99.0.10/24", :cpus => 2, :mem => 3072 },
}

workers = {
  "k8s-w01" => { :ip => "10.99.0.20/24", :cpus => 2, :mem => 3072 },
  "k8s-w02" => { :ip => "10.99.0.21/24", :cpus => 2, :mem => 3072 },
}


Vagrant.configure("2") do |config|
  
  config.vm.box = "generic/ubuntu2204"
  config.vm.network "public_network", bridge: "Lan 99", auto_config: false

  workers.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |worker|
      worker.vm.hostname = hostname
      worker.vm.provider :hyperv do |hv|
        hv.cpus = info[:cpus]
        hv.memory = info[:mem]
        hv.maxmemory = info[:mem]
      end 
      worker.vm.provision "shell", path: "provision/configure.sh", args: [info[:ip],gateway]
    end
  end

  masters.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |master|
      master.vm.hostname = hostname
      master.vm.provider :hyperv do |hv|
        hv.cpus = info[:cpus]
        hv.memory = info[:mem]
        hv.maxmemory = info[:mem]
      end
      master.vm.provision "shell", path: "provision/configure.sh", args: [info[:ip],gateway]
      master.vm.provision "file", source: "provision/ansible", destination: "/home/vagrant/ansible"
      master.vm.provision "ansible_local" do |ansible|
        ansible.provisioning_path = "/home/vagrant/ansible"
        ansible.playbook = "playbook.yaml"
        ansible.inventory_path = "hosts.yaml"
        ansible.limit = "all"
      end
    end
  end  
end
