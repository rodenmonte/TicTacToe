#!/usr/bin/env bash

for ttt_test in *_test.rb; do
  echo "Running $ttt_test"
  ruby $ttt_test
done

