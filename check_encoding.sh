#!/bin/bash
if [ $# -eq 1 ]; then
  if [ -d $1 ]; then
    export log="yourlog"
    echo "" > $log
    for i in `ls /pathtofiles/$1 | grep -i .sql$`; do
      char=`file -i /pathtofiles/$1/$i | cut -d"=" -f2`
      if [ "$char" = "utf-8" ]; then
        iconv -f $char -t iso-8859-1//TRANSLIT /pathtofiles/$1/$i > /pathtofiles/$1/output.sql
        mv /pathtofiles/$1/output.sql /pathtofiles/$1/$i
        echo "Se ha modificado el charset de $i" >> $log
      fi
    echo "$i: `file -i /pathtofiles/$1/$i | cut -d"=" -f2`" >> $log
    done
  else
    echo "No se encuentra el directorio."
    exit 1
  fi
else
  echo "Numero de parametros incorrectos."
  echo "Uso del script: sh check_scripts.sh nombre_carpeta"
  exit 1
fi