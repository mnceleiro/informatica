# Manejando múltiples máquinas

## Script básico multimáquina
A continuación probamos un script básico con 3 máquinas:

```rb
Vagrant.configure("2") do |config|

  # Configuracion de la maquina1 (pc1)
  config.vm.define :pc1 do |pc1|
    pc1.vm.box = "ubuntu/jammy64"
    pc1.vm.hostname = "pc1"
  end

  # Configuracion de la maquina2 (pc2)
  config.vm.define :pc2 do |pc2|
    pc2.vm.box = "ubuntu/jammy64"
    pc2.vm.hostname = "pc2"
  end

  # Configuracion de la maquina2 (pc3)
  config.vm.define :pc3 do |pc3|
    pc3.vm.box = "mnceleiro/ubuntu24"
    pc3.vm.hostname = "pc3"
  end
end
```

Fíjate que ahora ya no usamos la variable **config** para definir los parámetros, sino la de cada máquina. Con config definimos las máquinas, y luego tenemos variables para definir los parámetros de cada máquina.

!!! Ejercicio

    1. Ejecuta el script (puede que haya algún error, si lo hay arréglalo). Si el error está en alguna máquina que no existe o no es compabible, cámbiala por una Debian 12.
    2. Modifica el script para que la máquina 3 tenga 4096 de RAM y nombre de equipo Linux: "terminator".
    3. Haz que en la máquina 3 se cree un fichero "bienvenida.txt" en /home/vagrant sin contenido al arrancarla.

## Cambiando las propiedades de red
### Adaptador puente
El equivalente al modo "bridge" o puente de virtualbox se puede lograr añadiendo esta línea en el Vagrantfile:

- config.vm.network "public_network".

Si quieres una ip fija:

- config.vm.network "public_network", ip: "192.168.0.200"

De esta manera tu máquina virtual estará en la misma red que tu máquina host.

### Red interna
Si quieres puedes tener la máquina en red interna introduciendo lo siguiente:

- config.vm.network "private_network", ip: "192.168.11.250"

Esto pondrá tu máquina en red interna con esa ip.

## Agrupando las máquinas
Con la siguiente línea puedes agrupar la máquina en un sitio concreto:

```rb
vb.customize ["modifyvm", :id, "--groups", "/nombre-grupo"]
```

## Ejercicio final
Destruye completamente las máquinas que has creado. Después, modifica el Vagrantfile para que soporte lo siguiente:

1. Las tres máquinas deberán estar en la misma red privada, con ips 192.168.33.10, .11 y .12.
2. PC1, además de estar en la red privada anterior, debe estar también en red con tu máquina (bridge).
3. Mete las tres máquinas en el mismo grupo, que se llamará: "practica-vagrant-daw".
4. Finalmente, levanta la máquina y comprueba en Virtualbox que todo se ha hecho correctamente. Mira cuántas interfaces de red tienen pc1, pc2 y pc3 y verifica que las máquinas están en el grupo indicado.