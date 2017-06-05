# Code Runner

To keep this application safe and secure, run it in its own linux container.

# Prerequisites

Use linux

Have docker installed on your linux machine.

# Build

To create executable: 
        
        ./build.sh

To create docker image: 

        sudo docker image build --tag code-runner:0.1 .

# Run


To run in the background:

        sudo docker container run --detach -p 8080:8080 code-runner:0.1

# Notes

This application accepts an http POST with "Filename" as a key in the header and the file's contents in the body.

The response sent back contains the program's output to Stdout.

# Supported Languages
- Go
- C
- C++
- Java
- Python 3