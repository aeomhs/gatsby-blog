#!/bin/zsh

title=""
date=$(date +%Y-%m-%d)
time=$(date +%H:%M:%S)
# "2020-06-28T20:45:00.000Z"
datetime="\"${date}T${time}.000Z\""
description=""
publish="false"
content="---\ntitle: ${title}\ndate: ${datetime}\ndescription: ${description}\npublish: ${publish}\n---\n"

path="./content/blog/${date}"
COUNT=1

setopt NULL_GLOB

for DIR in ${path}*
do
    if [ -d "$DIR" ]
    then
            COUNT=$((COUNT+1))
    fi
done

unsetopt NULL_GLOB

path="${path}_${COUNT}"
/bin/mkdir $path

echo "$content" > "${path}/index.md"