#!/bin/bash

> oldFiles.txt
files=$(grep " jane " ../data/list.txt | cut -d ' ' -f 3)
#concat='~'
#echo $files
for file in $files;do
    #echo $concat$file
    if [ -e $HOME$file ];then
        echo $HOME$file >> oldFiles.txt;

    fi
done
