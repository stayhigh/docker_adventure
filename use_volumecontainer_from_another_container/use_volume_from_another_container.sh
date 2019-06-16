#!/bin/bash

set -x

# clean if previously exists a container called 'data'
if docker ps -a -f name=data
then
    docker stop data
    docker rm data
fi 

# create a volume container
docker create -v ./data --name data ubuntu:18.04

# use volume from another container (alpine container use ubuntu:18.04 container's volume)
docker run --rm --volumes-from data alpine ls -la ./data
