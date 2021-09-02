#!/bin/bash

DirWallet="451K8ZpJTWdLBKb5uCR1EWM5YfCUxdgxWFjYrvKSTaWpH1zdz22JDQBQeZCw7wZjRm3wqKTjnp9NKZpfyUzncXCJ24H4Xtr"
Hilos=$(cat /proc/self/status | grep pus_allowed_list | cut -d"-" -f2)

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
   
