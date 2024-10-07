# Redes en GNU/Linux

## Conceptos previos
Para entender esta parte hay que tener ciertos conceptos previos sobre redes. Algunos de ellos son:

- Direcciones IP públicas y privadas.
- IP de loopback, 127.0.0.1, localhost.
- Máscara de red (formato CIDR o no), 
- DHCP.
- Direcciones MAC.

## Comandos principales
### Comando: ip address
```bash title="Ver configuración IP"
ip address
```

| ![Comando ip address](../images/gnu-linux/networks/command-ip-address.png) |
| :-: |
| *Ejecución del comando "ip address" (3 interfaces de red, una es la de loopback)* |

El comando anterior puede sustituirse por `ip -4 address` o `ip -6 address` para ver solo la IPv4 o IPv6 del equipo.

### Comando: ping
Con el comando ping puedes comprobar si hay conectividad:

```bash
ping duckduckgo.com # (1)!
```

1. Se ejecuta indefinidamente. Pulsa "control" + "c" para parar el ping

!!! Note "Ejercicio" 

    1. Comprueba en una máquina virtual tu IP privada. Indica si está en la misma red que la IP de tu máquina host.
    2. Haz un ping desde la máquina host a la máquina virtual. ¿Funciona? ¿por qué?
    3. ¿Cuál es tu ip de loopback.
    4. Haz un ping a localhost, ¿funciona? ¿qué es localhost?
    5. Localhost está definido en algún sitio (por eso lo identifica tu sistema). Busca donde se define esa IP (y también se pueden crear nombres para otras ips).

=== "Ver conexiones (comando actual)"

    ```bash
    # Por defecto, ss muestra una lista de las conexiones establecidas
    ss

    # Si solo queremos los que están en escucha (listening)
    ss -l

    # ss -t (solo tcp), -u (solo udp), -x (solo unix) establecidas
    ss -t -u -x

    # Mostramos las TCP (pero no solo las que están establecidas, 
    # también los puertos en escucha: -a indica todas)
    ss -t -a

    # Ver la conexión de otra IP a tu servidor (solo esa ip)
    ss dst 192.168.1.100
    ```

=== "Ver conexiones (forma antigua con net-tools)"

    ```bash
    netstat
    netstat -a  # Muestra todas las conexiones (tcp y udp). Vemos todos los puertos en escucha.
    netstat -at # Solo TCP
    netstat -l  # Solo los puertos activos
    netstat -u  # Solo puertos UDP 
    ```

!!! Note "Ejercicio"
    Supongamos que ahora mismo estamos conectados por SSH desde nuestra máquina host a la máquina virtual. Esto es, desde el puerto 22 del host al 2222 de la máquina virtual. Si estás usando Vagrant esto es real.

    Intenta ver solamente esa conexión con el comando ss y con el comando netstat.


## Configuración tradicional: /etc/network/interfaces

## Configuración de red con Netplan
https://linuxconfig.org/netplan-network-configuration-tutorial-for-beginners

!!! Note "Ejercicio"
    Haz un backup de la configuración actual de netplan

## Otras configuraciones de red
## Protocolos HTTP y HTTPS
## Instalación de servidores web


## Referencias
- Linux.com Editorial Staff. An Introduction to the ss Command. Obtenido de https://www.linux.com/topic/networking/introduction-ss-command/. Última consulta 25/09/2024.