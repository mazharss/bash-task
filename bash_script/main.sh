#!/bin/bash

inputFile=$1;
propertyFile=$2;
outputFile=$3;

if [ -f "$inputFile" ] && [ -f "$propertyFile" ] && [ ! -z "$outputFile" ]; then

    cp -f "$inputFile" "$outputFile";

    #Loop for the property file
    while read -r line || [ -n "$line" ]; do

        #Parse the Key and Value
        key=$(echo $line | cut -f1 -d'=' | tr -d '\r');
        val=$(echo $line | cut -f2 -d'=' | tr -d '\r');
  
        #If Both are not blank, replace then string in the file.
        if [ ! -z "$key" ] && [ ! -z "$val" ]; then
            perl -pi -e "s/\\[\\[$key\\]\\]/$val/g" "$outputFile";
        fi
  
    done < "$propertyFile"
    
else
    echo "Incorrect arguments specified.";
    echo "Syntax: ./main.sh <path of the input file> <path of the property file> <path of the output file>.";
    echo "Example: ./main.sh ./input/index.html ./config/test.properties ./output/output.html";
    exit;
fi