#!/bin/bash

while IFS='' read -r line || [[ -n "$line" ]]; do
     [[ "$line" =~ ^#.*$ ]] && continue
    echo $line > temp.txt
    md5=($(md5sum ./temp.txt))

    if [ -e $md5.txt ]
	then
    	  mv $md5.txt ${md5}_1.txt
	  wget -q -O $md5.txt $line  
	  if [ $? -ne 0 ] 
		then 
		  echo "$line FAILED" 
	        else 
		  md5_1=($(md5sum ./${md5}.txt))
	  	  md5_2=($(md5sum ./${md5}_1.txt))
		  #echo $md5_1
		  #echo $md5_2
		  if [ $md5_1 != $md5_2 ] 
			then 
			  echo $line 
			
		  fi
		  
		  rm ${md5}_1.txt 
	  fi
	  
	  	
	else
    	  touch $md5.txt
	  wget -q -O $md5.txt $line  
	  if [ $? -ne 0 ]; 
		then 
		  echo "$line FAILED" 
	        else 
		  echo "$line INIT" 
	  fi
	      
    fi
done < "$1"
rm temp.txt
