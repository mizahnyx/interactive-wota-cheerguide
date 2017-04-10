# Manual interactivo de wotagei (ヲタ芸) para el concierto de °C-ute Cutie Circuit ~¡De vuelta a México!~

## Prerequisitos

### Linux

Se asume un Linux basado en paquetes de Debian, como Ubuntu o Mint, de 32 o 64 bits. Si no tienes Linux, puedes montarte una máquina virtual de Linux con Oracle VirtualBox.

### Paquetes de desarrollo requeridos por el motor Urho3D

Se necesitan instalar ciertos paquetes extra que necesita el motor de juegos de video Urho3D


```
sudo apt install libx11-dev libxrandr-dev libasound2-dev git cmake make

# Ubuntu y Mint requieren el siguiente comando también
sudo apt install build-essential
```

### Node JS, última versión

Nos bajamos el paquete del sitio oficial de NodeJS (versión LTS 6.10.2) y lo descomprimimos en un lugar estándar, por ejemplo, en `/opt/`. El subdirectorio ``bin` del directorio principal de NodeJS lo deberemos agregar a nuestra variable `$PATH`, a trávés, por ejemplo, de una línea al final de nuestro archivo ``-bashrc`:


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

### Descargar el proyecto con Git

```
git clone --recursive https://github.com/mizahnyx/interactive-wota-cheerguide
cd interactive-wota-cheerguide
```
