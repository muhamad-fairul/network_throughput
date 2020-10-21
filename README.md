# Docker network benchmark

Very simple benchmark of the network between a docker host and a container.

It sends a big file over TCP to a docker container and measures the throughput
using pv.

Host OS requirements:

* netcat
* pv (pipe viewer)
* dd
* docker

## Usage

```
$ ./benchmark.sh
Building docker benchmark container
Generating test data
Sending 100MiB to docker container
 100MiB 0:00:00 [1,03GiB/s] [===============================>] 100%
```

Want to send a bigger or smaller file? Change the `MEGABYTES` variable in
`benchmark.sh`.

That's all.