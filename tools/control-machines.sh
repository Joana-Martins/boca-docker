#!/bin/bash

if [ "$1" == "users" ]; then
    for i in `ls runs-submitted*.txt`; do
	a=""
	cat $i | while read lin; do
	    if [ "$a" == "" ]; then
		a=$lin
	    else
		a1=`echo $a | cut -d'-' -f1`
		l1=`echo $lin | cut -d'-' -f1`
		if [ "$a1" != "$l1" ]; then
		    echo "$i $a1 $l1"
		    a=$lin
		fi
	    fi
	done
    done
else
    if [ "$1" == "gencodes" ]; then
	while read lin; do 
	    #First Surname:email@gmail.com:Sao Paulo:SP:spsp:46:48479:146:qrw3
	    pas="`echo -n $lin | cut -d':' -f9`"
	    pas="`echo -n $pas | sha256sum - | cut -f1 -d' '`"
	    astring="xyzxyzxyz"
	    pass="`echo -n "${astring}$pass" | sha256sum - | cut -f1 -d' '`"
	    echo "`echo -n $lin | cut -d':' -f5` $pas $pass 0"
	done
    else    
	for arquivo in runs-submitted-1-1-*txt; do
	    TIME="$(cut -d'-' -f5 <<< "$arquivo")"
	    printf "$TIME "
	    grep '\-2[0-1][0-9]\-' $arquivo|cut -d'-' -f1 |sort -u|wc -l
	done
    fi
fi


###example of generating score.sep
###First Surname:email@gmail.com:Sao Paulo:SP:spsp:46:48479:146:qrw3
# #!/bin/bash
# while read lin; do 
#   prefix="`echo -n $lin | cut -d':' -f8`"
#   prenam="`echo -n $lin | cut -d':' -f5`"
#   echo "$prenam ${prefix}000/${prefix}399/1 # /^team${prenam}/ /^staff${prenam}/ /^score${prenam}/"
#   echo "${prenam}ccl ${prefix}000/${prefix}500/1 # /^staff${prenam}/ /^teamccl${prenam}/ /^judge/"
# done
# #!/bin/bash
# i=1
# j=1
# k=1
# while [ $i -le 49 ]; do
#    let "jj = $j + 1"
#    let "ii = $i - 1"
#    let "ff = $ii * 100 + 50000"
#    let "gg = $i * 100 + 49999"
#    echo "sede$i $ff/$gg/1 # /^team${j}\$/ /^team${jj}\$/ /^staff${i}\$/"
#    let "i = $i + 1"
#    let "j = $j + 2"
# done
