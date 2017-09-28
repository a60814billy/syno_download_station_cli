#!/bin/bash 

./listTask.sh | grep finished | awk '{print $1}' | xargs | sed -e 's/ /,/g'
