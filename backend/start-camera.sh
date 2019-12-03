#!/bin/bash
cd /home/pi/mjpg-streamer/mjpg-streamer-experimental/
export LD_LIBRARY_PATH=.
mjpg_streamer -o "output_http.so -w ./www" -i "input_raspicam.so -fps 30 -x 640 -y 360"