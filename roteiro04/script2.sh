#!/bin/bash

#login : senha : UID : GID : Nome Completo : Diretório $HOME : shell

userReport() {
	echo =========================================================
	user=`grep ^$1 /etc/passwd | awk -F":" '{print $1}'`
	echo Relatório d\o Usuário: $user
	echo
	echo UID: `grep ^$1 /etc/passwd | awk -F":" '{print $3}'`
	echo Nome ou Descrição: `grep ^$1 /etc/passwd | awk -F":" '{print $5}'`
	echo
	home=`grep ^$1 /etc/passwd | awk -F":" '{print $6}'`
	echo Total Usado no $home: `du -sh $home | awk -F" " '{print $1}'`
	echo
	echo Último Login:
	echo `lastlog -u $user`
        echo =========================================================
}

userReport $1
