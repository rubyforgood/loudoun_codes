#!/bin/bash


FILE=$1 # Input File (Solution to test input against)

BASENAME=${FILE%.*} # File basename
BASENAME=${BASENAME##*/} # without directory

# TODO: implement command line flag for input/output directories
INPUT_DIR=inputs
OUTPUT_DIR=outputs

INPUT_FILE=$INPUT_DIR/$BASENAME.in
OUTPUT_FILE=$OUTPUT_DIR/$BASENAME.out

if [[ -f $INPUT_FILE && -f $OUTPUT_FILE ]]; then
  echo "Test files loaded…"
else
  >&2 echo "ERROR LOADING TEST FILES!"
fi

# TODO: implement command line flag for language
LANGUAGE=ruby

exec $LANGUAGE $FILE < $INPUT_FILE | diff -w $OUTPUT_FILE -

if [ $? -eq 0 ]; then
  echo "SUCCESS!"
else
  echo "EPIC FAILURE!"
fi
