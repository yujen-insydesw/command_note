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
