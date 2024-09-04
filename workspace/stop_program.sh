#! /bin/bash

PROG_NAME=gitlab-runner

stopProg.sh $PROG_NAME



stopProg.sh
#! /bin/bash

function GET_PID() {
	PROG_NAME=$1
	HT_PID=$(ps -efa | grep -w $PROG_NAME run | grep -v grep | grep -v tail | grep -v vi | grep -v 'sh -c'| awk '{print $2}')
	return $HT_PID
}

PROG_NAME=$1

GET_PID $PROG_NAME
HT_PID=$?
if [ "x$HT_PID" != "x" ]; then
	if kill -SIGQUIT $HT_PID ; then
		echo ""
    echo " ++++++++++++++++++++++++++++++++++++++++"
    echo " $PROC_NAME (pid $HT_PID) stopped  "
    echo " ++++++++++++++++++++++++++++++++++++++++"
	else
    echo ""
    echo " ++++++++++++++++++++++++++++++++++++++++"
    echo " $PROC_NAME could not be stopped   "
    echo " ++++++++++++++++++++++++++++++++++++++++"
    fi
else
    echo ""
    echo " ++++++++++++++++++++++++++++++++++++++++"
    echo " $PROC_NAME process is not running "
    echo " ++++++++++++++++++++++++++++++++++++++++"
fi
