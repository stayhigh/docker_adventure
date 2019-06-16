#!/bin/bash
set -x

target_storage_driver="overlay2"

# start docker
sudo systemctl start docker

# check current storage driver
current_storage_driver=$(docker info | grep "Storage Driver" | awk -F":" '{gsub(/^ +| +$/,"",$2);print $2}')
echo ${current_storage_driver}
echo ${target_storage_driver}

if [[ "${current_storage_driver}" == "${target_storage_driver}" ]]
then
    echo "The current_storage_driver equals target_storage_driver: ${target_storage_driver}"
    exit -1
else
    # stop docker
    sudo systemctl stop docker
    
    # create a backup of existing setup
    sudo cp -au /var/lib/docker /var/lib/docker.bk
    
    # Create the docker deamon config to tell docker to use overlay2
    echo -e "{ \"storage-driver\": \"${target_storage_driver}\" }" | sudo tee /etc/docker/daemon.json
    
    # Start docker
    sudo systemctl start docker
fi

