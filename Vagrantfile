# -*- mode: ruby -*-
# vi: set ft=ruby :

MASTER_NODE_HOSTNAME = 'master'
WORKER_NODE_HOSTNAME = 'worker'
MASTER_IP = '192.168.56.109'
WORKER_IP = '192.168.56.110'
CPU_CORES_COUNT = 1
MEMORY_COUNT = 512


# create machines config
Vagrant.configure("2") do |config|
	config.vm.box = "bento/debian-12.9"
	config.vm.provider "virtualbox" do |v|
		v.memory = MEMORY_COUNT
		v.cpus = CPU_CORES_COUNT
		id_rsa_pub = File.read("#{Dir.home}/.ssh/id_rsa.pub")
		config.vm.provision "copy ssh public key", type: "shell",
		inline: "echo \"#{id_rsa_pub}\" >> /home/vagrant/.ssh/authorized_keys"
	end
  # master node 1
	config.vm.define 'Master' do |master|
		master.vm.hostname = MASTER_NODE_HOSTNAME
		master.vm.network :private_network, ip: MASTER_IP
		master.vm.synced_folder "shared",
        "/home/vagrant/host_shared_folder"
		master.vm.provision "shell",
        privileged: true, path: "setup.sh"
		master.vm.provider "virtualbox" do |v|
			v.name = MASTER_NODE_HOSTNAME
			v.memory = MEMORY_COUNT
			v.cpus = CPU_CORES_COUNT
		end
	end
  # worker node 1
	config.vm.define 'Worker' do |worker|
		worker.vm.hostname = WORKER_NODE_HOSTNAME
		worker.vm.network :private_network, ip: WORKER_IP
		worker.vm.synced_folder "shared",
        "/home/vagrant/host_shared_folder"
		worker.vm.provision "shell",
        privileged: true, path: "setup.sh"
		worker.vm.provider "virtualbox" do |v|
			v.name = WORKER_NODE_HOSTNAME
			v.memory = MEMORY_COUNT
			v.cpus = CPU_CORES_COUNT
		end
	end
end
