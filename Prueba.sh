#!/bin/bash

Hilos=$(dmidecode -t processor | grep ore | grep ount | cut -d ":" -f 2 | cut -d " " -f 2)
echo $Hilos

