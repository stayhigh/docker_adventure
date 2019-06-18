#!/bin/bash
### https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes#a-docker-cheat-sheet

# Purging All Unused or Dangling Images, Containers, Volumes, and Networks
docker system prune

# To additionally remove any stopped containers and all unused images (not just dangling images), add the -a flag to the command:
docker system prune -a

# Removing Docker Images, list & remove
docker images -a
docker rmi <Image> <Image>

# Remove dangling images, list & remove
docker images -f dangling=true
docker images purge

# Removing images according to a pattern, list & remove
docker images -a |  grep "pattern"
docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi

# Remove all images
docker images -a
docker rmi $(docker images -a -q)

# Removing Containers
docker ps -a
docker rm ID_or_Name ID_or_Name

# Remove a container upon exit
docker run --rm image_name

# Remove all exited containers
docker ps -a -f status=exited
docker rm $(docker ps -a -f status=exited -q)

# Remove containers using more than one filter, list & remove
docker ps -a -f status=exited -f status=created
docker rm $(docker ps -a -f status=exited -f status=created -q)

# Remove containers according to a pattern
docker ps -a | grep "pattern" | awk '{print $3}' | xargs docker rmi

# Stop and remove all containers, list & remove
docker ps -a
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

# Removing Volumes, list & remove
docker volume ls
docker volume rm volume_name volume_name

# Remove dangling volumes - Docker 1.9 and later
docker volume ls -f dangling=true
docker volume prune

# Remove a container and its volume
docker rm -v container_name

