#!/usr/bin/env bash

GAZEBO_MODELS_DIR="$HOME/.gazebo/models"
if [ ! -d "$GAZEBO_MODELS_DIR" ]; then
    echo "Deploying pre-cached Gazebo models to $GAZEBO_MODELS_DIR"
    mkdir -p "$GAZEBO_MODELS_DIR"
    cd "$GAZEBO_MODELS_DIR"
    tar zxf /gazebo_models_cache.tgz
    cd /
fi
