## Examen de GNU/Linux de lo visto hasta aquí
### Vagrantfile

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

$script = <<-SCRIPT
	apt update && apt install -y lsb-core tree vim
SCRIPT

Vagrant.configure("2") do |config|

  config.vm.box = "hashicorp/bionic64"
  config.vm.box_version = "1.0.282"

  config.vm.provider :virtualbox do |vb|
    vb.name = "examen-20240312"
    vb.memory = "2048"
    vb.gui = true

    vb.customize ["modifyvm", :id, "--groups", "/examenes-sistemas-informaticos"]
  end

  config.vm.hostname = "examen-20240312"
  config.vm.synced_folder "./examen-nombre-apellido1", "/home/vagrant/examen-nombre-apellido1",
	  owner: "vagrant",
	  group: "vagrant",
	  mount_options: ["dmode=755,fmode=755"]

  config.vm.boot_timeout = 1000
  config.vm.provision "shell", inline: $script
end
```
### Examen
