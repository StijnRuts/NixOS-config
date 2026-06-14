#!/usr/bin/env bash

cores=$(nproc)

for ((i=1; i<=cores; i++)); do
    echo "\${cpubar cpu$i}"
done
