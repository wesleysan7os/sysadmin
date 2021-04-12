#!/bin/bash

echo ==================================================
echo Relatório da Máquina: `uname -a | awk -F" " '{print $2}'`
echo Data/Hora: `date +"%a %b %d %T %:::z %Y"`
echo ==================================================
echo
echo Máquina Ativa desde: `uptime -s`
echo
echo Versão \d\o Kernel: `uname -r`
echo
echo CPUs:
echo Quantidade de CPUs/Core: `cat /proc/cpuinfo | grep -c processor`
echo Modelo da CPU: `head /proc/cpuinfo | grep 'model name' | awk -F":" '{print $2}'` 
echo
echo Memória Total: `free --mega | grep Mem | awk -F" " '{print $2}'` MB
echo
echo Partições:
df -h > temp
cat temp
