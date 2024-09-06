#! /bin/bash

function GET_PID() {
    #PROG_NAME=$1
    #HT_PID=$(ps -efa | grep -w $PROG_NAME | grep -v grep | grep -v tail | grep -v vi | grep -v 'sh -c'| awk '{print $2}')

    PROG_NAME=$1
    HT_PID=$(pgrep -x $1)
    echo $HT_PID
}

function KILL_PID() {
    PROC_NAME=$1
    PID=$2
    if kill -9 $PID ; then
        echo "$PROC_NAME (pid $PID) stopped  "
    else
        echo "$PROC_NAME could not be stopped   "
    fi
}

# Main

# Usage
if [ -z $1 ]; then
    echo "Usage: $0 <program_name>"
    exit 1
fi

# Get pid
PROG_NAME=$1
HT_PID=$(GET_PID $PROG_NAME)
# Break string into list
IFS=' ' read -r -a HT_PID <<< $HT_PID

# Check empty
if [ ${#HT_PID[@]} -eq 0 ]; then
    echo "$PROC_NAME process is not running "
    exit 0
fi

# Kill pid
for PID in ${HT_PID[@]}
do
    KILL_PID $PROG_NAME $PID
done