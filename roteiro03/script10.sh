#!/bin/bash

if [ `date +%H` -lt 12 ]
then
	echo Bom dia
elif
	[ $(date +%H) -lt 18 ]; then
	echo Boa tarde
else
	echo Boa noite
fi
