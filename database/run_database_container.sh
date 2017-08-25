#!/bin/bash

# run this from in the directory that has the cockroach-data folder

docker network create roachnet

# -p 26257:26257 -p 8000:8080  \

docker run -d \
--name hcroach \
--hostname hcroach \
--net roachnet \
-p 8000:8080 \
-v "${PWD}/cockroach-data:/cockroach/cockroach-data"  \
cockroachdb/cockroach:v1.0.5 start --insecure