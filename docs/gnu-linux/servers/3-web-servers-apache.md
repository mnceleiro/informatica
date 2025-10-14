# Actividad guiada: Instalación de servidores web en entornos Windows y GNU/Linux

Hemos visto anteriormente donde está la configuración por defecto de Apache (donde se indica el DocumentRoot del mismo), esto es en el fichero `000-default.conf`.

Ahora, ¿qué podemos hacer si queremos tener varios sitios (p. ej: 3 páginas web) en el mismo servidor? Para eso utilizamos **VirtualHosts**.

## Creando el entorno con Vagrant
Aunque podrías hacerlo con Virtualbox, con Vagrant te será más sencillo. Te dejo el script a ejecutar:

```rb
Vagrant.configure("2") do |config|

  # Configuracion de la maquina1 (servidor) sin GUI (hay que conectarse con "vagrant ssh")
  config.vm.define :servidor do |servidor|
    servidor.vm.box = "ubuntu/jammy64"
    servidor.vm.hostname = "2vms-servidor"

    servidor.vm.provider :virtualbox do |vb|
      vb.gui = false
      vb.name = "servidor"
      vb.cpus = 1
      vb.memory = 1024
      vb.customize ["modifyvm", :id, "--groups", "/practicas-daw"]
    end

    servidor.vm.provision "shell", inline: <<-SHELL
        apt update
    SHELL
  end

  # Configuracion de la maquina2 (cliente) con GUI
  config.vm.define :cliente do |cliente|
    cliente.vm.box = "mnceleiro/ubuntu24"
    cliente.vm.hostname = "2vms-cliente"

    cliente.vm.provider :virtualbox do |vb|
      vb.gui = true
      vb.name = "2vms-cliente"
      vb.cpus = 1
      vb.memory = 4096
      vb.customize ["modifyvm", :id, "--groups", "/practicas-daw"]
    end

    cliente.vm.provision "shell", inline: <<-SHELL
        apt update
    SHELL
  end
end
```

Guarda el texto anterior con el nombre "Vagrantfile" (sin extensión). Luego, abre un terminal en la carpeta donde está el fichero y escribe `vagrant up`. Esto descargará y levantará la máquina.

Para conectarte al servidor o cliente por terminal puedes usar el comando `vagrant ssh servidor` o `vagrant ssh cliente`. Para apagar las máquinas: `vagrant halt` y para destruirlas `vagrant destroy -f`.

### Configurando un VirtualHost
Vamos a configurar nuestro primer Virtualhost. Para ello, en la carpeta `/etc/apache2/sites-available` donde tenemos el `000-default.conf` crearemos otro fichero (yo le he llamado `mi-web-1.conf`).

```

```