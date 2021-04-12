#!/bin/bash

users=`awk -F":" '{if($3>=1000 && $1 != "nobody"){print $6}}' /etc/passwd`
for user in $users
do
	echo Usuario: $user 
	echo Arquivos JPG: `find $user -name '*.jpg' | wc | awk -F" " '{print $1}'`
	echo Arquivos MP3: `find $user -name '*.mp4' | wc | awk -F" " '{print $1}'`
	echo Arquivos MP4: `find $user -name '*.mp3' | wc | awk -F" " '{print $1}'`
	echo
done
