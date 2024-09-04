#! /bin/bash

function GET_PID() {
	PROG_NAME=$1
	HT_PID=$(ps -efa | grep -w $PROG_NAME | grep -v grep | grep -v tail | grep -v vi | grep -v 'sh -c'| awk '{print $2}')
	return $HT_PID
}

PROG_PATH=$1
PROG_NAME=$2
PROG_COMMAND=$3

GET_PID $PROG_NAME
HT_PID=$?
if [ "x$HT_PID" != "x" ]; then
        echo ""
        echo " ++++++++++++++++++++++++++++++++++++++++"
        echo " $PROG_NAME process is already running..."
        echo " ++++++++++++++++++++++++++++++++++++++++"
        exit 0
fi

$BINARY_PATH/$PROC_NAME $PROG_COMMAND
#sleep 1

GET_PID PROG_NAME
HT_PID=$?
if [ "x$HT_PID" != "x" ]; then
        echo ""
        echo "$ ++++++++++++++++++++++++++++++++++++++++"
        echo "$ Execute $PROC_NAME success  "
        echo "$ ++++++++++++++++++++++++++++++++++++++++"
else
        echo ""
        echo " ++++++++++++++++++++++++++++++++++++++++"
        echo " Execute $PROC_NAME failed   "
        echo " ++++++++++++++++++++++++++++++++++++++++"
fi