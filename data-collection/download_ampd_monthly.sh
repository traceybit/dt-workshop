#!/bin/bash

dir="$1"
cd "$dir"

for i in 2019

    do mkdir -p $i
    cd $i
    
    # download all files in 2020 monthly ftp directory
    wget -nc ftp://newftp.epa.gov/DMDnLoad/emissions/hourly/monthly/$i/*

    # unzip all annual zip files
    unzip '*.zip'

    # once we have only .txt files, we can remove the zip files
    rm *.zip
    
    cd ..
    done
