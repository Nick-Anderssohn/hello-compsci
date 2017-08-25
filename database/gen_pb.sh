#!/bin/bash

protoc -I=$GOPATH/src/hello-compsci/database/proto/ --go_out=$GOPATH/src/hello-compsci/database/pb $GOPATH/src/hello-compsci/database/proto/*.proto
protoc -I=$GOPATH/src/hello-compsci/database/proto/ --dart_out=$GOPATH/src/hello-compsci/frontend-server/client/lib/pb $GOPATH/src/hello-compsci/database/proto/*.proto