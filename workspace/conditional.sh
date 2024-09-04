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