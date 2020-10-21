#! /bin/bash

MEGABYTES=100
TMPFILE=$(mktemp)

echo "Building docker benchmark container"
docker build -t netcat . > /dev/null

container=$(docker run -d --publish=8000:8000 netcat -l -p 8000)

sleep 1

echo "Generating test data"
yes helloworld | dd if=/dev/stdin of=$TMPFILE bs=1M count=$MEGABYTES iflag=fullblock 2> /dev/null

echo "Sending ${MEGABYTES}MiB to docker container"

pv "$TMPFILE" | netcat localhost 8000

rm "$TMPFILE"
