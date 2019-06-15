#!/bin/bash
## How to build a docker container from scratch (Docker basics — a must know):
## https://medium.com/faun/how-to-build-a-docker-container-from-scratch-docker-basics-a-must-know-395cba82897b

### Lifecycle of Docker Container:
### https://medium.com/@nagarwal/lifecycle-of-docker-container-d2da9f85959

set -x 

# create a image with Dockerfile
docker build -t clever .

# run a contain with the specfied image
docker run -d -p 80:80 clever
