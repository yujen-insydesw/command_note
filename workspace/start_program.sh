#! /bin/bash

function GET_PID() {
    HT_PID=$(pgrep -x $1)
    echo $HT_PID
}

# Main

# Usage
if [ -z $1 ]; then
    echo "Usage: $0 <program_name program_command>"
    echo "Usage: $0 ./helloworld  ...             "
    exit 1
fi

# Get input
PROGRAM=("$@")
echo input: ${PROGRAM[@]}
NAME=${PROGRAM[0]//[.\/]}
echo program: $NAME
# note: //[.\/] means remove . and / in string

# Check program
HT_PID=$(GET_PID $NAME)
if ! [ -z $HT_PID ]; then
    echo "$NAME process is already running..."
    exit 0
fi

# Execute program
${PROGRAM[@]} &
#$BINARY_PATH/$PROC_NAME $PROG_COMMAND &
#sleep 1

# Check program
HT_PID=$(GET_PID $NAME)
if ! [ -z $HT_PID ]; then
    echo "Execute $NAME success  "
else
    echo "Execute $NAME failed   "
fi