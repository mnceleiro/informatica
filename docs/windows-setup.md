# Windows Server

## Descarga

Para descargar cualquier sistema operativo de Microsoft en versión de prueba se puede acceder al [centro de evaluación de microsoft](https://www.microsoft.com/en-us/evalcenter/) y posteriormente seleccionar el sistema operativo deseado.
![](/images/windows/ws-download1.png)  

## Versiones
En WS 2019 tenemos lo siguiente, de más barato a más caro:
- **Windows Server 2019 Essential**. Destinado a pequeños negocios y con un máximo de 25 usuarios pueden conectarse a el y 50 dispositivos. Actualmente Microsoft recomienda **no usar** esta versión y utilizar, en su lugar, su solución de servidores en la nube Microsoft 365.
- **Windows Server 2019 Standard**: bueno para entornos físicos (que no usan máquinas o casi no usan máquinas virtuales). Viene solamente con dos licencias virtuales (es decir, podemos instalar WS2019 Standard con dos VMs en HyperV pero no incrementar a una tercera a no ser que la compremos). Además, si usamos el servidor físico para cualquier otra cosa que no sea esas dos máquinas virtuales entonces consumirá una de esas licencias.
- **Windows Server 2019 Datacenter**: viene con licencias ilimitadas para ejecutar máquinas virtuales (esto es, puedes crear tantas VMs como quieras).
- **Hyper-V server 2019**: servidor dedicado de máquinas virtuales con Hyper-V. Se puede descargar de la web de Microsoft con infinitas máquinas virtuales. Viene sin GUI y no podemos hacer otra cosa que albergar en el máquinas virtuales.

Las diferencias más grandes que hay entre las versiones Standard y Datacenter es el número de licencias para virtualización.

Se pueden descargar versiones de evaluación de cualquier sistema operativo de Microsoft desde [aquí](https://www.microsoft.com/es-es/evalcenter/).
# Instalaciones desatendidas

# Configuraciones básicas en WS 2019

# Referencias
- Kevin Brown. Windows Server 2019 Administration. Udemy. Curso disponible en: https://www.udemy.com/course/windows-server-2019-administration-h/
- 