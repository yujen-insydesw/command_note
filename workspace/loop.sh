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