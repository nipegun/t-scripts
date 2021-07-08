#!/bin/bash

DirWallet="451K8ZpJTWdLBKb5uCR1EWM5YfCUxdgxWFjYrvKSTaWpH1zdz22JDQBQeZCw7wZjRm3wqKTjnp9NKZpfyUzncXCJ24H4Xtr"

echo ""
echo "  Actualizando los paquetes de Termux..."
echo ""
pkg update
pkg upgrade

echo ""
echo "  Descargando el repositorio de XMRig..."
echo ""
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

#echo ""
#echo "  Generando un identificador de dispositivo con el UUID..."
#echo ""
#pkg install -y ossp-uuid
#uuid > ~/IdDispositivo.txt
#Dispositivo=$(cat ~/IdDispositivo.txt)
#echo ""
#echo "El identificador del dispositivo es:"
#echo "$Dispositivo"
#echo ""

#echo ""
#echo "  Generando un identificador de dispositivo con el IMEI..."
#echo ""
#pkg install -y termux-api
#termux-telephony-deviceinfo > ~/IdDispositivoIMEI.txt
#Dispositivo=$(cat ~/IdDispositivoIMEI.txt)
#echo ""
#echo "El identificador del dispositivo es:"
#echo "$Dispositivo"
#echo ""

echo ""
echo "  Generando un identificador de dispositivo con la MAC de la WiFi..."
echo ""
Dispositivo=$(ip addr show wlan0 | grep link/ether | cut -d " " -f6)
echo ""
echo "El identificador del dispositivo es:"
echo "$Dispositivo"
echo ""

echo ""
echo "  Ejecutando minero..."
echo ""
./xmrig -o pool.minexmr.com:443 --rig-id=$Dispositivo -u $DirWallet
#/data/data/com.termux/files/home/xmrig/build/xmrig

