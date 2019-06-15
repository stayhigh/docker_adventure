#!/bin/bash

set -x

container_name=lifecycletest
image=alpine
docker pull alpine && echo 'IMAGE alpine already pulled ..'
if [[ $(docker ps -a | grep ${container_name}) ]]
then
    echo 'kill & remove used name'
    docker stop ${container_name}
    docker rm ${container_name} && sleep 1
fi

# NOTE: -t option is a must, it will not show "UP" without -t option
container_id=$(docker create --name ${container_name} -t -i ubuntu:18.04 bash | head -c 12)
# create and run new container: docker run -d -it --name ${container_name} ${image}

docker start "${container_name}"
docker stop "${container_name}"
docker start "${container_name}"

docker pause "${container_name}"
docker unpause "${container_name}"
docker restart  "${container_name}"
docker stop "${container_name}"
docker rm "${container_name}"
