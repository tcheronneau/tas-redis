#!/usr/bin/env bash 
#

which dgoss > /dev/null 2>&1
REQUIREMENTS=$?
if [ "${REQUIREMENTS}" == "1" ]; then echo -e "This script require dgoss to be installed.\nPlease check readme for more details." ; exit 1; fi;

echo "Building redis image ..."
docker build -t redis . 
echo "Building redis secure image ..."
docker build -t redis-secure --build-arg PASS=supersecurepass -f Dockerfile_secure . 

echo "Testing redis image ..."
dgoss run redis

echo "Testing redis secure image ..."
GOSS_FILE=goss_secure.yaml dgoss run redis-secure

