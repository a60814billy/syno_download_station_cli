#!/bin/bash 

./listTask.sh -s | egrep "$1" | awk '{print $1}' | xargs | sed -e 's/ /,/g'
