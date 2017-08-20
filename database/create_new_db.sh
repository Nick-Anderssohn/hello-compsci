#!/bin/bash
# run this script from inside the database directory!!!!

echo "deleting old database"
sudo rm -rf cockroach-data
mkdir cockroach-data

echo "starting cockroach container"
docker run -d \
--name=build-roach \
-v ${PWD}/cockroach-data:/cockroach/cockroach-data  \
cockroachdb/cockroach:v1.0.4 start --insecure

echo 'wait 2 seconds for container to start completely'
sleep 2

echo "creating user nick"
docker exec -it build-roach /bin/sh -c "/cockroach/cockroach user set nick --insecure"

echo "creating database helloCompSci"
docker exec -it build-roach /bin/sh -c "/cockroach/cockroach sql --insecure -e 'CREATE DATABASE helloCompSci'"

echo "granting user nick access to database helloCompSci"
docker exec -it build-roach /bin/sh -c "/cockroach/cockroach sql --insecure -e 'GRANT ALL ON DATABASE helloCompSci TO nick'"

echo "stopping cockroach container"
docker stop build-roach

echo "removing cockroach container"
docker rm build-roach