#!/bin/bash

docker stop hcroach
docker rm hcroach
./create_new_db.sh
./run_database_container.sh
