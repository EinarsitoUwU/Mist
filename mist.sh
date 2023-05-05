#!/bin/bash
#Einarssini script for search in all dirs
ruta=~/*
owo=1
red='\033[31m'
reset='\033[0m'
rutao=~/.*
if [[ $3 = -sensible ]]
then
 for (( i=0; i<$2; i++ ))
 do
  grep -l -s -w "$1" $ruta >> /tmp/mist.log
  grep -l -s -w "$1" $rutao >> /tmp/mist.log
  ruta=$ruta'/*'
  rutao=$rutao'/.*'
 done
else
 for (( i=0; i<$2; i++ ))
 do
  grep -l -s -i "$1" $ruta >> /tmp/mist.log
  grep -l -s -i "$1" $rutao >> /tmp/mist.log
  ruta=$ruta'/*'
  rutao=$rutao'/.*'
 done
fi
while IFS= read -r line
do
  echo -e "($owo) found \033[31m $1 \033[0m in : \033[36m $line $reset"
  let owo=$owo+1
done < /tmp/mist.log
echo -e "\033[35m Open () $reset:"
read option
opti=$(echo $option | cut -d ' ' -f 2 )
option=$(echo $option | cut -d ' ' -f 1 )
owo=1
if [[ $opti = v  ]]
 then
  while IFS= read -r line
  do
   if [[ $option = $owo ]]
    then
     nvim $line
   fi
   let owo=$owo+1
  done < /tmp/mist.log
else
 owo=1
 while IFS= read -r line
 do
  if [[ $option = $owo ]]
  then
   bat $line
  fi
  let owo=$owo+1 
 done < /tmp/mist.log
fi 
rm /tmp/mist.log
