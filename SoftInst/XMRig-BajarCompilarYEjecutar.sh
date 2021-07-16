#!/bin/bash

DirWallet="451K8ZpJTWdLBKb5uCR1EWM5YfCUxdgxWFjYrvKSTaWpH1zdz22JDQBQeZCw7wZjRm3wqKTjnp9NKZpfyUzncXCJ24H4Xtr"
Hilos=$(cat /proc/self/status | grep pus_allowed_list | cut -d"-" -f2)

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
echo "  Obteniendo dirección mac de la tarjeta inalámbrica..."
echo ""
DirMACWlan0=$(ip addr show wlan0 | grep link/ether | cut -d" " -f6)
echo ""
echo "  La dirección MAC de la tarjeta inalámbrica es: $DirMACWlan0"
echo ""

echo ""
echo "  Generando un identificador del minero a partir de la MAC $DirMACWlan0..."
echo ""
IdMinero=$(echo -n $DirMACWlan0 | md5sum | cut -d" " -f1)
echo ""
echo "  El identificador de este minero es: $IdMinero"
echo ""

echo ""
echo "  Ejecutando minero con identificador $IdMinero..."
echo ""

## Con TLS
./xmrig -o pool.minexmr.com:443 --threads=$Hilos --rig-id=$Dispositivo -u $DirWallet --tls 

## Sin TLS
   #./xmrig -o pool.minexmr.com:4444 --threads=$Hilos --rig-id=$Dispositivo -u $DirWallet

#/data/data/com.termux/files/home/xmrig/build/xmrig

