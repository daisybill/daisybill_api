#!/usr/bin/env bash

source .getRubies.sh
source .getGemset.sh

gemset=$(getGemset $1)

set -e

for i in "${rubies[@]}"
do
  echo "====================================================="
  echo "$i@$gemset : Start Test"
  echo "====================================================="
  rvm $i@$gemset exec bundle exec rspec spec
  echo "====================================================="
  echo "$i: End Test"
  echo "====================================================="
done
