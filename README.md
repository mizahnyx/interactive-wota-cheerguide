# Manual interactivo de wotagei (ヲタ芸) para el concierto de °C-ute Cutie Circuit ~ ¡De vuelta a México! ~

## Prerequisitos

### Linux

Se asume un Linux basado en paquetes de Debian, como Ubuntu o Mint, de 32 o 64 bits. Si no tienes Linux, puedes montarte una máquina virtual de Linux con Oracle VirtualBox.

### Paquetes de desarrollo requeridos por el motor Urho3D

Se necesitan instalar ciertos paquetes extra que necesita el motor de juegos de video Urho3D


```
sudo apt install libx11-dev libxrandr-dev libasound2-dev git cmake make
sudo apt install libgl1-mesa-dev

# Ubuntu y Mint requieren el siguiente comando también
sudo apt install build-essential
```

### Node JS, última versión

Nos bajamos el paquete del sitio oficial de NodeJS (versión LTS 6.10.2) y lo descomprimimos en un lugar estándar, por ejemplo, en `/opt/`. El subdirectorio `bin` del directorio principal de NodeJS lo deberemos agregar a nuestra variable `$PATH`, a trávés, por ejemplo, de una línea al final de nuestro archivo `.bashrc`:


```
export PATH=$PATH:/opt/node-v6.10.2-linux-x86/bin

```

### Emscripten

Emscripten es un compilador de C/C++ a un subconjunto altamente optimizado de JavaScript conocido como asm.js, basado en Clang. Si tu sistema operativo es de 64 bits, en vez de `sdk-master-32bit` deberás instalar `sdk-master-64bit`.

```
cd /tmp
tar -xf ~/Descargas/emsdk-portable.tar.gz 
sudo mv emsdk-portable /opt
sudo su -

# Éstos comandos se ejecutan como root
cd /opt/emsdk-portable/
export PATH=$PATH:/opt/node-v6.10.2-linux-x86/bin
./emsdk update
./emsdk install sdk-master-32bit # sdk-master-64bit para sistemas de 64 bits
exit

# De vuelta como usuario normal
# Ésto sólo necesita ejecutarse una sola vez, para activar el SDK
# de Emscripten para el usuario actual
/opt/emsdk-portable/emsdk activate sdk-master-32bit
```

### Blender3D y la plugin de exportación de Urho3D

El ejecutable de Blender 3D, con el plugin de exportación de Urho3D instalado, debe de estar en el `$PATH`. Dicho plugin se puede bajar de

[https://github.com/reattiva/Urho3D-Blender](https://github.com/reattiva/Urho3D-Blender)

## Construcción del proyecto

### Descargar el proyecto con Git

```
git clone --recursive https://github.com/mizahnyx/interactive-wota-cheerguide
cd interactive-wota-cheerguide
```

### Compilación de Urho3D

Se requiere compilar para Linux y para Emscripten a la vez, debido a que necesitamos el AssetImporter de la versión para Linux para importar el escenario desde Blender3D. Previamente hay que cargar las variables de entorno de Emscripten, que están en el archivo `emsdk_env.sh` dentro del directorio de instalación de Emscripten Portable. 

```
source /opt/emsdk-portable/emsdk_env.sh
make build/urho3d.x11
make build/urho3d.emscripten
```

### Compilación y ejecución del proyecto

Para compilar y ejecutar el sitio introducimos los siguientes comandos desde el directorio principal del proyecto:

```
make build/game.data
make build/game.emscripten
cd site
npm install
# Dos veces, la primera para instalar dependencias, la segunda para construir la página
npm install 
./node_modules/.bin/gulp connect
```

El sitio se podrá acceder con un navegador en `http://localhost:8080`.
