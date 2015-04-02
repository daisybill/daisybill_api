#!/usr/bin/env bash

source .getRubies.sh
source .getGemset.sh

gemset=$(getGemset $1)

for i in "${rubies[@]}"
do
  rvm $i install
  rvm $i gemset create $gemset
  rvm $i@$gemset exec bundle install
done
