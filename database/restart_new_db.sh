#!/bin/bash

docker stop classroach
docker rm classroach
./create_new_db.sh
./run_database_container.sh
