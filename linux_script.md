# Linux script

## Notice
- 一些前置詞prefix不要用(像是PATH), 會干擾到cat等程式
- 如果script在/home/<user>執行, 那script內使用pwd就是當下路徑
- 在windows編寫或接觸script容易有問題
```console
# To solve /bin/bash^M: bad interpreter
sed -i -e 's/\r$//' <xxx.sh>
```

## Basic usage
```console
#
./<xxx.sh>

#
＄ps -ef | grep <xxx.sh>
＄pgrep <xxx.sh>

# ID:17802 and kill
kill -9 -17802
```

## #!
This sequence of characters is the shebang. It tells the operating system that the following path should be used as the interpreter for the script.
- #!/bin/bash: Uses the Bash shell.
- #!/bin/sh: Uses the Bourne shell or a compatible shell.
- #!/usr/bin/env python: Uses the Python interpreter found in the user’s environment.
- #!/usr/bin/perl: Uses the Perl interpreter.

## Common

<details>
<summary>$  ${}  $()  $(( ))</summary>

```console
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
```
</details>

<details>
<summary>if else</summary>

```console
#!/bin/bash

# if [...]; then ...
# elif [...]; then ...
# else ...
# fi

if ! [ -d ${1} ]; then
    echo Directory ${1} not exist 
elif ! [ -f ${1} ]; then
    echo File ${1} not exist
else
    echo ${1} not exist
fi
```
</details>

<details>
<summary>loop</summary>

```console
#!/bin/bash

echo list:
files=(file0 file1 file2 file3)
for file in ${files[@]}
do
    echo ${file}
done

echo list directory:
# ls
# -p : append / if it is a dirctory
# -v : skip
files=$(ls -p | grep -v .sh)
for file in ${files[@]}
do
    echo ${BASEDIR}/${file}
done
```
</details>

<details>
<summary>receive input</summary>

```console
#!/bin/bash

# Function to check if input is a number
is_number() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to check if input contains specific content
contains_content() {
    if [[ $1 == *"$2"* ]]; then
        return 0
    else
        return 1
    fi
}

# Main script

# Command
# ./recieve.sh 3
# ./recieve.sh hello world
# ./recieve.sh 3 "say hello world"

# Run with interactive way:
#read -p "Enter a value: " input

# Run with value assigned:
input=$1
# Count the number of additional arguments
args=("$@")
echo Number arguments: ${#args[@]}
echo ${args[@]}
echo ""

# Check if the input is a number
if is_number "$input"; then
    echo "The input is a number."
else
    echo "The input is not a number."
fi

# Check if the input contains the word 'hello'
if contains_content "$input" "hello"; then
    echo "The input contains 'hello'."
else
    echo "The input does not contain 'hello'."
fi
```
</details>

<details>
<summary>use function</summary>

```console
#!/bin/bash

function say_hello() {
    echo hello world
}
say_hello

function gen_word() {
    echo hello
}
echo $(gen_word)

function add_num() {
    local sum=$(( $1 + $2 ))
    return $sum
}
add_num 1 2
echo test 1 + 2 = $?
```
</details>

<details>
<summary>call another script</summary>

### 2 approach
```console
# Runs the script in a new process. Variables and functions are not shared.
./another_script.sh

# Runs the script in the same process. Variables and functions are shared.
source another_script.sh
```
### script
```console
#!/bin/bash

# method 1
# my_function() {
#    echo hello world
#}
source ./another_script.sh
res=$(my_function)
echo say: $res

# method 2
# my_function() {
#    global_res="hello world"
#}
source ./another_script.sh
my_function
echo say: $global_res

# method 3
# my_function() {
#    return "hello world"
#}
source ./another_script.sh
my_function
res=$?
echo say: $res
```
</details>

## My tool

<details>
<summary>make directory</summary>

```console
#!/bin/bash

function is_exist() {
    if [ -d $1 ]; then
        return 0
    else
        return 1
    fi
}

# Main

# Check if the directory name is provided as an argument
if [ -z $1 ]; then
    echo "Usage: $0 <directory_name>"
    exit 1
fi

# Create the directory
if is_exist $1; then
    echo Already existed $1
    exit 1
else
    mkdir -p $1
fi

# Confirm the directory
if is_exist $1; then
  echo Directory $1 created successfully.
else
  echo Failed to create directory $1.
fi
```
</details>

<details>
<summary>use ftp</summary>

```console
ftp -n $host <<END_SCRIPT
quote USER $user
quote PASS $pass
cd <...>
ls
mkdir <...>
put <element>
get <element>
quit
END_SCRIP
```
</details>

<details>
<summary>read .json</summary>

raw.json
```console
{
    "id": 3,
    "message": {
            "id": 333,
            "string": "raw"
    }
}
```
script
```console
#!/bin/bash

# Main

# use jq
# jq .message.string raw.json

# Check if names is provided as an argument
if [ -z $2 ]; then
    echo "Usage: $0 <.nest.nest...> <json>"
    exit 1
fi

# Extract information
result=$(jq $1 $2)

# Check result
if [ -z $result ]; then
    echo null
else
    echo $result
fi
```
</details>

<details>
<summary>read .ini</summary>

config.ini
```console
[main]
description = Sample configuration
timeout = 10
monitoring_interval = 20
 
[database]
server = db.example.org
port = 3306
username = dbuser
password = dbpass
```
script
```console
#!/bin/bash

# Function to read an INI file
read_ini_file() {
    local filename="$1"
    local section=""
    while IFS=' = ' read -r key value; do
        if [[ $key =~ ^\[(.*)\]$ ]]; then
            section="${BASH_REMATCH[1]}"
        elif [[ $key && $value ]]; then
            key=$(echo $key | tr -d ' ')
            value=$(echo $value | tr -d ' ')
            eval "${section}_${key}='${value}'"
        fi
    done < "$filename"
}

# Main

ini_file="config.ini"
read_ini_file $ini_file

# Reveal the values
#echo "Description: $main_description"
#echo "Database Server: $database_server"
```
</details>



## Optional

### How to restart via script

https://superuser.com/questions/1362291/auto-restart-an-executable-after-the-application-crashes
