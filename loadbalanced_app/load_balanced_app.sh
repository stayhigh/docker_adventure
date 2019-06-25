#!/bin/bash

set -x


# create an image
docker build --tag=friendlyhello .

# run the app
docker run -d -p 4000:80 friendlyhello

# tag the image
docker tag friendlyhello gordon/get-started:part2

#######Run your new load-balanced app
# set swarm manager
docker swarm init

# Our single service stack is running 5 container instances of our deployed image on one host. 
docker stack deploy -c docker-compose.yml getstartedlab

# Get the service ID for the one service in our application:
docker service ls

# A single container running in a service is called a task. Tasks are given unique IDs that numerically increment, up to the number of replicas you defined in docker-compose.yml. List the tasks for your service:
sudo docker service ps getstartedlab_web

# check web services
curl -4 http://localhost:4000

#  view all tasks of a stack
sudo docker stack ps getstartedlab

# Take the app down with docker stack rm:
docker stack rm getstartedlab

# Take down the swarm.
docker swarm leave --force
