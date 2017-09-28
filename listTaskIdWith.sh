#!/bin/bash 

./listTask.sh | grep "$1" | awk '{print $1}' | xargs | sed -e 's/ /,/g'
