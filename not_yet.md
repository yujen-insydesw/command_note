

//////////////////// script 尚未



<details>
<summary>linux script</summary>

```console

	注意事項
一些前置詞不要用 像是PATH 會干擾到cat等程式
如果scrip在/ap執行 那pwd就是/ap

	在windows容易有問題
/bin/bash^M: bad interpreter
sed -i -e 's/\r$//' script.sh

	起script
./xxx.sh

	查詢script
＄ps -ef | grep xxx.sh
＄pgrep xxx.sh
找到ID:17802殺script
kill -9 -17802

	起手
#/bin/bash

	$	${} $()
BASEDIR=/Speedy/rmdata
TODAY=$(date +Y%m%d)
cat_result=$(cat $file_name | grep -a 000001)
使用
$BASEDIR
${TODAY}
${${string}:${start_pos}:${length}}
用$(( ))去 + - ...
result=$((1 + 2))

	List of files
# method (1)
#LIST FILES=$(1s -p /Speedy/rmdata/ I grep -a $TODAY I grep -v /)
# Using Is -p tells Is to append a slash to entries which are a directory, and using grep -v / tells grep to return only lines not containing a slash.
# method (2)
LIST_FILES=(${BASEDIR}/es_balance_${TODAY}.txt ${BASEDIR}/es_balance_extend_${ODAY}.txt)

	$1 $2 ...
file_name=$1
$0: shell script 的名稱

	function
#
function appendFile() {
	file_name=$1
	cat_result=$(cat $file_name I grep -a 000001)
	str_start=6
	str_len=$(expr length $cat_result - $str_start)
	append_line=000002${cat_result:$str_start:$str_len}
	echo $append line » $file name
}
for var_file in ${LIST_FILE[@]}
do
	appendFile $var_file
done
#
function mkDir() {
	DIR=$1
	if [ -d $DIR ]; then 
		#rm $1/*
		rm -rf $DIR
		mkdir -p $DIR
	else
		mkdir -p $DIR
	fi
}
mkDir <directory>
#
function add_numbers() {
    local sum=$(( $1 + $2 ))
    return $sum
}
add_numbers 5 10
echo $?

	Whether exist?
Program
which <program_name>
Directory & file:
if ! [ - d <path> ]; then echo “Directory does not exist." fi
if ! [ - f <file> ]; then echo "File does not exist." fi

	if
#
if [...]; then ...
elif [...]; then ...
else ...
fi
#
if [ $HO_RUNNING -eq 1 ]; then
#
if ! [...]; then

	loop
s_web_id...is a file
WEBID_LIST=$(cat s_web_id | awk '{print $1}')
for WEBID in ${WEBID_LIST[@]}
do
    $BATCH_PATH/UserStart.sh $WEBID
done
```
</details>

<details>
<summary>mkDir</summary>

```console
function mkDir() {
	DIR=$1
	if [ -d $DIR ]; then 
		#rm $1/*
		rm -rf $DIR
		mkdir -p $DIR
	else
		mkdir -p $DIR
	fi
}
```
</details>

<details>
<summary>ftp</summary>

```console
ftp -n $host <<END_SCRIPT
quote USER $user
quote PASS $pass
mkdir $MONTHDIR
cd $MONTHDIR
mkdir $HOSTNAME
cd $HOSTNAME
put $element
quit
END_SCRIP
```
</details>


<details>
<summary>read ini</summary>

```console
raw.ini
[session1]
key1=a
key2=b
key3=c
[session2]
key1=...
...

readIni.sh
file=raw.ini
ln=$(sed -n '/\[session1\]/=' $file)
lnd=$(($ln + 3))
sed -n $ln','$lnd'p' $file | sed -n '/key3/p' | awk -F= '{print $2}'
```
</details>

<details>
<summary>read json</summary>

```console
raw.json
{
        "message": {
                "id": 4095,
                "temperature": 409.5
        },
        "origin": "receiver",
        "protocol": "alecto_wsd17",
        "uuid": "0000-b8-27-eb-0f3db7",
        "repeats": 3
}

readJson.sh
jq .message.temperature raw.json
```
</details>

<details>
<summary>execute program / script</summary>

```console
program_name=hello.sh
$(pwd)/$program_name
./$program_name
```
</details>

<details>
<summary>get path</summary>

```console
function get_parent_path() {
  path=$(dirname $(dirname $(realpath $0)))
  echo $path
	return $path
}
get_parent_path
```
</details>

<details>
<summary>start stop</summary>

```console

使用 1
#! /bin/bash

PROG_PATH="/ap"
PROG_NAME=gitlab-runner
USER="speedy"
WORKING_DIR="/ap/apuser-runner"
CONFIG="/ap/.gitlab-runner/config.toml"

PROG_COMMAND="run --working-directory $WORKING_DIR --config $CONFIG -user $USER &"

startProg.sh $BINARY_PATH $PROC_NAME $PROG_COMMAND
注意$PROG_COMMAND字串前面一定不能是空格...似乎會判斷錯誤

使用 2
#! /bin/bash

第一種
PROC_NAME_LIST="qs_data_adapter qs_tse_stock qs_tse_other qs_otc_stock qs_otc_other qs_taifex_future qs_taifex_option qs_emg_stock"
for PROC_NAME in $PROC_NAME_LIST
do
	...
done

第二種
WEBID_LIST=$(cat $DATA_PATH/s_web_id | awk '{print $1}')
for WEBID in ${WEBID_LIST[@]}
do
    ./startProg_WEBID.sh $WEBID
done
這個就會需要多一點參數了




startProg.sh
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



使用stop
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

```

future ...
restart ...
https://superuser.com/questions/1362291/auto-restart-an-executable-after-the-application-crashes
</details>