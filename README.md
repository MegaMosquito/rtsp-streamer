# rtsp-streamer

A Linux container that serves an RTSP stream from a V4L2 camera.

Usage:

```
make build
make run
```

It's configured to publish the stream from `/dev/video0` on host port 8554, with path '/unicast'. Once it is up and running, you can use this URL in your RTSP viewer (e.g., VLC):

rtsp://<IPADDRESS>:8554/unicast

(where '<IPADDRESS>' is your host IP address).

Tested on a Raspberry Pi Zero 2W, with the Raspberry Pi High Def camera.

