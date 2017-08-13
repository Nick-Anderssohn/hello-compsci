#!/bin/bash
docker stop code-runner
docker rm code-runner
docker run --net helloclass_hello-compsci-network -ditp 8079:8079 --name code-runner code-runner
