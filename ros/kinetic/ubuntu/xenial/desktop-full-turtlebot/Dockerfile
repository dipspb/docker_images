# dipspb/ros:kinetic-turtlebot
FROM osrf/ros:kinetic-desktop-full

MAINTAINER dipspb@gmail.com

RUN apt-get update && \
    apt-get install -y \
        ros-kinetic-turtlebot-simulator \
        ros-kinetic-turtlebot-teleop \
        ros-kinetic-turtlebot-rviz-launchers \
        ros-kinetic-velodyne \
        ros-kinetic-velodyne-simulator \
        ros-kinetic-octomap \
        ros-kinetic-octomap-mapping \
        tmux \
        vim-nox \
    && \
    rm -rf /var/lib/apt/lists/*

# Turtlebot + VLP-16
COPY config/kobuki_hexagons_VLP-16.urdf.xacro /opt/ros/kinetic/share/turtlebot_description/robots/

COPY config/env.txt /
RUN cat env.txt >> /root/.bashrc ; \
    rm /env.txt

COPY config/tmux.conf /root/.tmux.conf
COPY config/tmux-banner.txt /
RUN echo "cat <<_EOD" >> /root/.bashrc ; \
    cat tmux-banner.txt >> /root/.bashrc ; \
    echo "_EOD" >> /root/.bashrc ; \
    rm /tmux-banner.txt
