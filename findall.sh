#!/bin/bash

if [ "$1" == "" ] ; then
    echo Use: findall.sh strToFind
    exit
fi

find . -type f | grep -v ".git/" | grep -v "garbage/" | \
        grep -v "/__" | grep -v ".pyc" | grep -v "venv/" |
        grep -E "*.c$|*.h$|*.py$|*.v$|*.vh$" | xargs -i grep -H $@ {}

# EOF
