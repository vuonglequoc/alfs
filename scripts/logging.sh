#!/bin/bash

# Make logging function
timestamp() {
  date +%d-%m-%Y_%H:%M:%S
}

logging()
{
  # logging $ALFS toolchain binutils-pass-1
  echo "$(timestamp) $3 start"
  $1/$2/$3.sh 1>$1/logs/$2/$3.log 2> $1/logs/$2/$3.err.log
  echo "$(timestamp) $3 end"
}

export -f timestamp
export -f logging
