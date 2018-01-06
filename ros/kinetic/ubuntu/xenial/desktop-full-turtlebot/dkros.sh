#!/usr/bin/env bash

MASTER_IP="127.0.0.1"
GAZEBO_MASTER_URI="http://${MASTER_IP}:11345"
ROS_MASTER_URI="http://${MASTER_IP}:11345"

echo '----------------------------------------'
echo "DISPLAY: \"$DISPLAY\""
echo "CMD: $@"
echo "GAZEBO_MASTER_URI: $GAZEBO_MASTER_URI"
echo "ROS_MASTER_URI: $ROS_MASTER_URI"
echo '----------------------------------------'

xhost +local:root

docker run --rm -ti \
	-p 11345:11345 \
	-p 11311:11311 \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /tmp/.ros:/root/.ros \
	-v /tmp/.gazebo:/root/.gazebo \
	--device=/dev/dri:/dev/dri \
	-e DISPLAY \
	-e QT_X11_NO_MITSHM=1 \
	-e ROS_IP=$MASTER_IP \
	-e ROS_MASTER_URI \
	-e GAZEBO_IP=$MASTER_IP \
	-e GAZEBO_MASTER_URI \
	dipspb/ros:kinetic-turtlebot $@

