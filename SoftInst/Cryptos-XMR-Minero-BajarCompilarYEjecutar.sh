#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-----------------------------------------------------------------------------------------------------
#  Script de NiPeGun para actualizar bajar el código fuente, compilar y ejecutar el minero de monero
#-----------------------------------------------------------------------------------------------------

DirWallet="451K8ZpJTWdLBKb5uCR1EWM5YfCUxdgxWFjYrvKSTaWpH1zdz22JDQBQeZCw7wZjRm3wqKTjnp9NKZpfyUzncXCJ24H4Xtr"
Hilos=$(cat /proc/self/status | grep pus_allowed_list | cut -d"-" -f2)

echo ""
echo "  Actualizando los paquetes de Termux..."
echo ""
pkg update -y
pkg upgrade -y
pkg autoclean 	-y

echo ""
echo "  Descargando el repositorio de XMRig..."
echo ""
rm -rf ~/Cryptos/XMR/minero/
mkdir -p ~/Cryptos/XMR/
cd ~/Cryptos/XMR/
pkg install -y git
git clone https://github.com/xmrig/xmrig.git
cd xmrig

echo ""
echo "  Compilando..."
echo ""
mkdir build
cd build
pkg install -y cmake
cmake .. -DWITH_HWLOC=OFF
make -j $(nproc)

## Preparar la carpeta del minero
   mv ~/Cryptos/XMR/xmrig/build/ ~/Cryptos/XMR/minero/
   rm -rf ~/Cryptos/XMR/xmrig/

echo ""
echo "  Creando ID para el minero..."
echo ""

## A partir de la MAC WiFi
   ## Obtener MAC de la WiFi
      DirMACwlan0=$(ip addr show wlan0 | grep link/ether | cut -d" " -f6 | sed 's/://g')
   ## Generar un identificador del minero a partir de la MAC de la WiFi...
      IdMinero=$(echo -n $DirMACwlan0 | md5sum | cut -d" " -f1)

echo ""
echo "  Ejecutando minero con identificador:"
echo ""
echo "  $IdMinero..."
echo ""

## Con TLS
   ~/Cryptos/XMR/minero/xmrig -o pool.minexmr.com:443 --threads=$Hilos --rig-id=$IdMinero -u $DirWallet --tls 

## Sin TLS
   #~/Cryptos/XMR/minero/xmrig -o pool.minexmr.com:4444 --threads=$Hilos --rig-id=$IdMinero -u $DirWallet

#/data/data/com.termux/files/home/xmrig/build/xmrig

