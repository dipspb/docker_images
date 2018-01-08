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
        ros-kinetic-octomap-rviz-plugins \
        tmux \
        vim-nox \
    && \
    rm -rf /var/lib/apt/lists/*

# Cache gazebo models for turtlebot_world.world and map_creator.world
# Loosely based on https://github.com/PX4/containers/blob/master/docker/px4-dev/scripts/cache-gazebo-models.bash
# https://github.com/PX4/containers/blob/master/docker/px4-dev/scripts/cache-gazebo-models.bash
RUN mkdir /tmp/gazebo_models_cache && \
    mkdir /tmp/models && \
  	cd /tmp/models && \
  	for m in "cube_20k" "dumpster" "jersey_barrier" "ground_plane" "sun" "willowgarage"; do \
    		curl -Os "http://models.gazebosim.org/$m/model.tar.gz" && \
    		tar -zvxf model.tar.gz && \
            cp -vfR $m /tmp/gazebo_models_cache/; \
            rm model.tar.gz; \
  	done && \
  	cd .. && rm -r /tmp/models && \
    cd /tmp/gazebo_models_cache && tar zcf /gazebo_models_cache.tgz . && \
    cd / && rm -rf /tmp/gazebo_models_cache

# Deploy cached models on image entry point
COPY config/gazebo_models_entrypoint.sh /
RUN head -n -1 /ros_entrypoint.sh > /ros_entrypoint_new.sh && \
    echo ". /gazebo_models_entrypoint.sh" >> /ros_entrypoint_new.sh && \
    echo 'exec "$@"' >> /ros_entrypoint_new.sh && \
    mv /ros_entrypoint_new.sh /ros_entrypoint.sh && \
    chmod a+x /ros_entrypoint.sh

# Turtlebot + VLP-16
COPY config/kobuki_hexagons_VLP-16.urdf.xacro \
     /opt/ros/kinetic/share/turtlebot_description/robots/

# TMux config from https://gist.github.com/spicycode/1229612
COPY config/tmux.conf /root/.tmux.conf
COPY config/tmux-banner.txt /
RUN echo "cat <<_EOD" >> /root/.bashrc ; \
    cat tmux-banner.txt >> /root/.bashrc ; \
    echo "_EOD" >> /root/.bashrc ; \
    rm /tmux-banner.txt

# rosdep update
RUN rosdep update && \
    rosdep fix-permissions
