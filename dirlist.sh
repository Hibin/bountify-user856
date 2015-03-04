#!/bin/bash

recurse_primary() {
 for i in "."/*;do
    if [ -d "$i" ];then
        echo "- ${i:2}"
        recurse_secondary "$i" "-"
        echo ""
        echo "***"
        echo ""
    fi
 done
}

recurse_secondary() {
 for i in "$1"/*;do
    if [ -d "$i" ];then
        echo "$2- ${i:2}"
        recurse_secondary "$i" "$2-"
    fi
 done
}

cd $1

RESULTFILENAME=$2

if [[ $RESULTFILENAME =~ ^(.*)/([^/]+)$ ]] ; then
    RESULTFILENAME=${BASH_REMATCH[1]}/$(date +%F)-${BASH_REMATCH[2]}
else
    RESULTFILENAME=$(date +%F)-$RESULTFILENAME
fi

exec 1<&-
exec 1<>$RESULTFILENAME

recurse_primary

echo "Files count:" $(find ./ -type f | wc -l)
