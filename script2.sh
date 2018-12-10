#!/bin/bash
fname=$1

if [ -f $fname ]; then 
    tar -xzf $fname ./repos18
    #cd ${fname%.*} 
    cd repos18

    for filename in ./*.txt; do
    
        gfname="`cat $filename`"

	if [ ! -d "./assignments" ] ; then
    		mkdir ./assignments
	fi
	cd assignments
	git clone $gfname
	if [ $? -ne 0 ] 
		then 
		  echo "$gfname: cloning FAILED"
	else
		  echo "$gfname: cloning OK"
	fi
    	cd ..
	cd $filename
	echo "No of txt files: " ls -1 *.txt | wc -l
	echo "No of directories: " ls -l | grep -c ^d

    done

fi
