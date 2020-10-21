#!/bin/bash

set -eo pipefail

echo "Running netcat"
netcat "$@" > /dev/null
