#!/bin/bash

BASEDIR=$(pwd)
echo $(pwd): ${BASEDIR}
 
TODAY=$(date +%Y%m%d)
echo today $(date +%Y%m%d): ${TODAY}

string="...hello world..."
start_pos=3
length=11
substring=${string:start_pos:length}
echo say: ${substring}

# $0: This represents the name of the script being executed.
# realpath $0: This command converts the script’s relative path to an absolute path.
# dirname $(realpath $0): This extracts the directory part of the absolute path.
SCRIPTDIR=$(dirname $(realpath $0))
PARENTDIR=$(dirname $(dirname $(realpath $0)))
echo bash locate in: ${SCRIPTDIR}

left=1
right=2
sum=$(( left + right ))
echo operation: ${left} + ${right} = ${sum}

echo ""
