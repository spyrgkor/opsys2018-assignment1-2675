#!/bin/bash
process_line()
{
    echo $1 > temp.txt
    md5=($(md5sum ./temp.txt))

    if [ -e $md5.txt ]
	then
    	  mv $md5.txt ${md5}_1.txt
	  wget -q -O $md5.txt $line & 
	  wait
	  if [ $? -ne 0 ] 
		then 
		  echo "$1 FAILED" 
	        else 
		  #wait
		  md5_1=($(md5sum ./${md5}.txt))
	  	  md5_2=($(md5sum ./${md5}_1.txt))
		  if [ $md5_1 != $md5_2 ] 
			then 
			  echo $line 
			
		  fi
		  
		  if [ -e ${md5}_1.txt ] 
			then 
			  rm ${md5}_1.txt 
		  fi
	  fi
	  
	  	
	else
    	  touch $md5.txt
	  wget -q -O $md5.txt $1 &
	  wait
	  if [ $? -ne 0 ]; 
		then 
		  echo "$1 FAILED" 
	        else 
		  echo "$1 INIT" 
	  fi
	      
    fi

}
while IFS='' read -r line || [[ -n "$line" ]]; do
     [[ "$line" =~ ^#.*$ ]] && continue
     process_line $line &	
     #wait
done < "$1"

wait
#rm temp.txt

