#!/bin/bash -x

# Notes or running mongo so that it can be hit by another container
# (able to hit it as mongo://127.0.0.1:27017, but not from another container)
# Here's what we're doing... (to run a single mongo instance that is)
# https://success.docker.com/article/how-can-i-access-mongodb-container-from-another-container
# docker run --name mongo-solo -p 27017:27017  mongo:4.1.13   # works for Robot3T and local apps, but not from an app running in a container.
# docker run -it --entrypoint 'mongod --bind_ip_all' --name MONGODB --hostname MONGODB --net=bridge --expose 27017 mongo:4.1.13 bash
# docker run -it --name MONGODB --hostname MONGODB --net=bridge --expose 27017 mongo:4.1.13 bash
# docker run -it --name MONGODB --hostname MONGODB --network mcfdev --expose 27017 mongo:4.1.13 bash  # works but not for robo3T

# PARAMS:
flag=$1

echo
echo
clear

NETWORK_NAME="mcfdev"
externalPort=27017
internalPort=27017


# Create the network if it doesnt yet exist
netexists=`docker network ls -f name=$NETWORK_NAME -q`
if [ $netexists == "" ]; then
    echo "Creating bridge network: $NETWORK_NAME..."
    docker network create $NETWORK_NAME
    docker network ls -f name=$NETWORK_NAME
fi

# Removes an existing container (even if its currently running)
exists=$(docker container ls -a -f name=MONGODB -q)
if [ ! "$exists" == "" ]; then
    docker rm -f MONGODB
    echo "Removed existing container"
fi

if [ "$flag" == "-it" ]; then 
    # Interactive with bash prompt
    docker run -it \
      --name mongodb \
      --hostname mongodb \
      --network $NETWORK_NAME \
      --network-alias mcfmongo \
      --expose $internalPort \
      -p $externalPort:$internalPort \
      mongo:4.1.13 \
      bash  # Boom: Kindalin.

    # Then from the bash prompt inside the container...
    # mongod --bind_ip 0.0.0.0
    # OR
    # mongod --bind_ip_all

else
    # running in bg:
    # Q: Is --expose supposed to refer to the external port?
    docker run -d \
        --name MONGODB \
        --hostname MONGODB \
        --network $NETWORK_NAME \
        --network-alias mongodb \
        --expose $internalPort \
        -p $externalPort:$internalPort \
        mongo:4.1.13 \
        bash -c "mongod --bind_ip_all"

        # --entrypoint 'bash -c "mongod --bind_ip_all"' \
        
fi