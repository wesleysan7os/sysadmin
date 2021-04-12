#!/bin/bash

usersReport() {
   case $# in
      1) #caso tenha sido passado apenas 1 parametro para o script
         case $1 in
	         -all)
               cat /etc/passwd | awk -F":" '{print $1 $3 $5}'
               ;;
	         -human)
               cat /etc/passwd | awk -F":" '{if ($3>=1000){print $1 $3 $5}}'
	            ;;
         esac
	      ;;
      2) #caso tenham sido passados 2 parametros para o script
         case $1 in
            -all)
               case $2 in
                 -active)
                   for user in $(awk -F":" '{print $1}' /etc/passwd)
                   do
                     if [ `passwd -S $user | cut -d ' ' -f 2` = "P" ]
                     then
                        echo $user >> temp
                     fi
                   done
                   cat temp
                   ;;
                 -nonactive)
                   for user in $(awk -F":" '{print $1}' /etc/passwd)
                   do
                     if [ `passwd -S $user | cut -d ' ' -f 2` != "P" ]
                     then
                        echo $user >> temp
                     fi
                   done
                   cat temp
                   ;;
                 -order)
                   cat /etc/passwd | awk -F":" '{print $1 $2 $3}' > temp
                   sort temp
                   ;;
                 -groups)
                   while read p; do
                     USER=`echo "$p" | cut -d":" -f1`
                     printf "$p" | awk -v g="`groups $USER`" -F":" '{print $1 $3 $5 g}'
                   done </etc/passwd
                   ;;
                 -dir)
                   while read p; do
                     HOME=`echo "$p" | cut -d":" -f6`
                     printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 d}'
                   done </etc/passwd
                   ;;
               esac
               ;;
            -human)
              case $2 in
                -active)
                  for user in $(awk -F":" '{if ($3>=1000){print $1}}' /etc/passwd)
                   do
                     if [ `passwd -S $user | cut -d ' ' -f 2` = "P" ]
                     then
                        echo $user >> temp
                     fi
                   done
                   cat temp
                  ;;
                -nonactive)
                  for user in $(awk -F":" '{if ($3>=1000){print $1}}' /etc/passwd)
                   do
                     if [ `passwd -S $user | cut -d ' ' -f 2` != "P" ]
                     then
                        echo $user >> temp
                     fi
                   done
                   cat temp
                  ;;
                -order)
                  cat /etc/passwd | awk -F":" '{if ($3>=1000){print $1}}' > temp
                  sort temp
                  ;;
                -groups)
                  while read p; do
                     USER=`echo "$p" | cut -d":" -f1`
                     printf "$p" | awk -v g="`groups $USER`" -F":" '{if($3>=1000){print $1 $3 $5 g}}'
                  done </etc/passwd
                  ;;
                -dir)
                  while read p; do
                     HOME=`echo "$p" | cut -d":" -f6`
                     printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 d}}'
                  done </etc/passwd
                  ;;
              esac
              ;;
         esac
         ;;
      3) #caso tenham sido passados 3 parametros para o script
         case $1 in
           -all)
               case $2 in
                 -active)
                    case $3 in
                       -order)
                          for user in $(awk -F":" '{print $1}' /etc/passwd)
                          do
                             if [ `passwd -S $user | cut -d ' ' -f 2` = "P" ]
                             then
                                echo $user >> temp
                             fi
                          done
                          sort temp
                          ;;
                       -groups)
                          while read p; do
                             USER=`echo "$p" | cut -d":" -f1`
                             if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                             then
                               printf "$p" | awk -v g="`groups $USER`" -F":" '{print $1 $3 $5 g}'
                             fi
                          done </etc/passwd
                          ;;
                       -dir)
                          while read p; do
                             HOME=`echo "$p" | cut -d":" -f6`
                             USER=`echo "$p" | cut -d":" -f1`
                             if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                             then
                                printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 d}'
                             fi
                          done </etc/passwd
                          ;;
                    esac
                    ;;
                 -nonactive)
                    case $3 in
                       -order)
                          for user in $(awk -F":" '{print $1}' /etc/passwd)
                          do
                             if [ `passwd -S $user | cut -d ' ' -f 2` != "P" ]
                             then
                                echo $user >> temp
                             fi
                          done
                          sort temp
                          ;;
                       -groups)
                          while read p; do
                             USER=`echo "$p" | cut -d":" -f1`
                             if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                             then
                               printf "$p" | awk -v g="`groups $USER`" -F":" '{print $1 $3 $5 g}'
                             fi
                          done </etc/passwd
                          ;;
                       -dir)
                          while read p; do
                             HOME=`echo "$p" | cut -d":" -f6`
                             USER=`echo "$p" | cut -d":" -f1`
                             if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                             then
                                printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 d}'
                             fi
                          done </etc/passwd
                          ;;
                    esac
                    ;;
                 -order)
                    case $3 in
                      -groups)
                         while read p; do
                            USER=`echo "$p" | cut -d":" -f1`
                            printf "$p" | awk -v g="`groups $USER`" -F":" '{print $1 $3 $5 g}'  >> temp
                         done </etc/passwd
                         sort temp
                         ;;
                      -dir)
                         while read p; do
                            HOME=`echo "$p" | cut -d":" -f6`
                            printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 d}' >> temp
                         done </etc/passwd
                         sort temp
                         ;;
                    esac
                    ;;
                 -groups)
                    #$3 so pode ser dir
                    if [ $3 = "-dir" ]
                    then
                       while read p; do
                          USER=`echo "$p" | cut -d":" -f1`
                          HOME=`echo "$p" | cut -d":" -f6`
                          printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 g d}'
                       done </etc/passwd
                    fi
                    ;;
               esac
               ;;
           -human)
               case $2 in
                 -active)
                   case $3 in
                      -order)
                         for user in $(awk -F":" '{if($3>=1000){print $1}}' /etc/passwd)
                         do
                            if [ `passwd -S $user | cut -d ' ' -f 2` = "P" ]
                            then
                               echo $user >> temp
                            fi
                         done
                         sort temp
                         ;;
                      -groups)
                         while read p; do
                            USER=`echo "$p" | cut -d":" -f1`
                            if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                            then
                              printf "$p" | awk -v g="`groups $USER`" -F":" '{if($3>=1000){print $1 $3 $5 g}}'
                            fi
                         done </etc/passwd
                         ;;
                      -dir)
                         while read p; do
                            HOME=`echo "$p" | cut -d":" -f6`
                            USER=`echo "$p" | cut -d":" -f1`
                            if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                            then
                               printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 d}}'
                            fi
                         done </etc/passwd
                         ;;
                    esac
                    ;;
                 -nonactive)
                    case $3 in
                       -order)
                           for user in $(awk -F":" '{if($3>=1000){print $1}}' /etc/passwd)
                           do
                              if [ `passwd -S $user | cut -d ' ' -f 2` != "P" ]
                              then
                                 echo $user >> temp
                              fi
                           done
                           sort temp
                           ;;
                        -groups)
                           while read p; do
                              USER=`echo "$p" | cut -d":" -f1`
                              if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                              then
                                 printf "$p" | awk -v g="`groups $USER`" -F":" '{if($3>=1000){print $1 $3 $5 g}}'
                              fi
                           done </etc/passwd
                           ;;
                        -dir)
                           while read p; do
                              HOME=`echo "$p" | cut -d":" -f6`
                              USER=`echo "$p" | cut -d":" -f1`
                              if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                              then
                                 printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 d}}'
                              fi
                           done </etc/passwd
                           ;;
                    esac
                    ;;
                 -order)
                    case $3 in
                      -groups)
                         while read p; do
                            USER=`echo "$p" | cut -d":" -f1`
                            printf "$p" | awk -v g="`groups $USER`" -F":" '{if($3>=1000){print $1 $3 $5 g}}'  >> temp
                         done </etc/passwd
                         sort temp
                         ;;
                      -dir)
                         while read p; do
                            HOME=`echo "$p" | cut -d":" -f6`
                            printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 d}}' >> temp
                         done </etc/passwd
                         sort temp
                         ;;
                    esac
                    ;;
                 -groups)
                    #$3 so pode ser dir
                    if [ $3 = "-dir" ]
                    then
                       while read p; do
                          USER=`echo "$p" | cut -d":" -f1`
                          HOME=`echo "$p" | cut -d":" -f6`
                          printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{if($3>1000){print $1 $3 $5 g d}}'
                       done </etc/passwd
                    fi
                    ;;
               esac
               ;;
         esac
         ;;
      4) #caso tenham sido passados 4 parametros para o script
         case $1 in
           -all)
               case $2 in
                 -active)
                    case $3 in
                       -order)
                           case $4 in
                              -groups)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                                    then
                                       printf "$p" | awk -v g="`groups $USER`" -F":" '{print $1 $3 $5 g}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                              -dir)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                                    then
                                       printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 d}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                           esac
                           ;;
                       -groups)
                           #$4 so pode ser dir
                           if [ $4 = "-dir" ]
                           then
                              while read p; do
                                 USER=`echo "$p" | cut -d":" -f1`
                                 if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ] 
                                 then
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 g d}'
                                 fi
                              done </etc/passwd
                           fi
                           ;;
                    esac
                    ;;
                 -nonactive)
                    case $3 in
                       -order)
                           case $4 in
                              -groups)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                                    then
                                       printf "$p" | awk -v g="`groups $USER`" -F":" '{print $1 $3 $5 g}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                              -dir)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                                    then
                                       printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 d}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                           esac
                           ;;
                       -groups)
                           #$4 so pode ser dir
                           if [ $4 = "-dir" ]
                           then
                              while read p; do
                                 USER=`echo "$p" | cut -d":" -f1`
                                 if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ] 
                                 then
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 g d}'
                                 fi
                              done </etc/passwd
                           fi
                           ;;
                    esac
                    ;;
                 -order)
                     #se $2 é igual a -order, a unica sequencia correta possivel é $3 igual a -groups e $4 igual a -dir
                     if [ $3 = "-groups" ] && [ $4 = "-dir" ]
                     then
                        while read p; do
                          USER=`echo "$p" | cut -d":" -f1`
                          HOME=`echo "$p" | cut -d":" -f6`
                          printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 g d}' >> temp
                        done </etc/passwd 
                        sort temp
                     fi
                     ;;
               esac
               ;;
           -human)
               case $2 in
                 -active)
                    case $3 in
                       -order)
                           case $4 in
                              -groups)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                                    then
                                       printf "$p" | awk -v g="`groups $USER`" -F":" '{if($3>=1000){print $1 $3 $5 g}}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                              -dir)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                                    then
                                       printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 d}}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                           esac
                           ;;
                       -groups)
                           #$4 so pode ser dir
                           if [ $4 = "-dir" ]
                           then
                              while read p; do
                                 USER=`echo "$p" | cut -d":" -f1`
                                 if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ] 
                                 then
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 g d}}'
                                 fi
                              done </etc/passwd
                           fi
                           ;;
                    esac
                    ;;
                 -nonactive)
                    case $3 in
                       -order)
                           case $4 in
                              -groups)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                                    then
                                       printf "$p" | awk -v g="`groups $USER`" -F":" '{if($3>=1000){print $1 $3 $5 g}}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                              -dir)
                                 while read p; do
                                    USER=`echo "$p" | cut -d":" -f1`
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                                    then
                                       printf "$p" | awk -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 d}}' >> temp
                                    fi
                                 done </etc/passwd
                                 sort temp
                                 ;;
                           esac
                           ;;
                       -groups)
                           #$4 so pode ser dir
                           if [ $4 = "-dir" ]
                           then
                              while read p; do
                                 USER=`echo "$p" | cut -d":" -f1`
                                 if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ] 
                                 then
                                    HOME=`echo "$p" | cut -d":" -f6`
                                    printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 g d}}'
                                 fi
                              done </etc/passwd
                           fi
                           ;;
                    esac
                    ;;
                 -order)
                     #se $2 é igual a -order, a unica sequencia correta possivel é $3 igual a -groups e $4 igual a -dir
                     if [ $3 = "-groups" ] && [ $4 = "-dir" ]
                     then
                        while read p; do
                          USER=`echo "$p" | cut -d":" -f1`
                          HOME=`echo "$p" | cut -d":" -f6`
                          printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{if(3>=1000){print $1 $3 $5 g d}}' >> temp
                        done </etc/passwd 
                        sort temp
                     fi
                     ;;
               esac
               ;;
         esac
         ;;
      5) #caso tenham sido passados 5 parametros para o script...
         case $1 in
            -all)
               case $2 in
                  -active)
                     #unica sequencia correta possivel é $3 igual a -order, $4 igual a -groups e $5 = -dir
                     if [ $3 = "-order" ] && [ $4 = "-groups" ] && [ $5 = "-dir" ]
                     then
                        while read p; do
                           USER=`echo "$p" | cut -d":" -f1`
                           if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                           then
                              HOME=`echo "$p" | cut -d":" -f6`
                              printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 g d}' >> temp
                           fi
                           done </etc/passwd 
                           sort temp
                     fi
                     ;;
                  -nonactive)
                     #unica sequencia correta possivel é $3 igual a -order, $4 igual a -groups e $5 = -dir
                     if [ $3 = "-order" ] && [ $4 = "-groups" ] && [ $5 = "-dir" ]
                     then
                        while read p; do
                           USER=`echo "$p" | cut -d":" -f1`
                           if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                           then
                              HOME=`echo "$p" | cut -d":" -f6`
                              printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{print $1 $3 $5 g d}' >> temp
                           fi
                           done </etc/passwd 
                           sort temp
                     fi
                     ;;
               esac
               ;;
            -human)
               case $2 in
                  -active)
                     #unica sequencia correta possivel é $3 igual a -order, $4 igual a -groups e $5 = -dir
                     if [ $3 = "-order" ] && [ $4 = "-groups" ] && [ $5 = "-dir" ]
                     then
                        while read p; do
                           USER=`echo "$p" | cut -d":" -f1`
                           if [ `passwd -S $USER | cut -d ' ' -f 2` = "P" ]
                           then
                              HOME=`echo "$p" | cut -d":" -f6`
                              printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 g d}}' >> temp
                           fi
                           done </etc/passwd 
                           sort temp
                     fi
                     ;;
                  -nonactive)
                     #unica sequencia correta possivel é $3 igual a -order, $4 igual a -groups e $5 = -dir
                     if [ $3 = "-order" ] && [ $4 = "-groups" ] && [ $5 = "-dir" ]
                     then
                        while read p; do
                           USER=`echo "$p" | cut -d":" -f1`
                           if [ `passwd -S $USER | cut -d ' ' -f 2` != "P" ]
                           then
                              HOME=`echo "$p" | cut -d":" -f6`
                              printf "$p" | awk -v g="`groups $USER`" -v d="`du -sh $HOME`" -F":" '{if($3>=1000){print $1 $3 $5 g d}}' >> temp
                           fi
                           done </etc/passwd 
                           sort temp
                     fi
                     ;;
               esac
               ;;
         esac
   esac
   printf "" > temp
}

usersReport $1 $2 $3 $4 $5
