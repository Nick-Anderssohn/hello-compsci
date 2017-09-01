#  Copyright (C) 2017  Nicholas Anderssohn

# Intermediate container to build service
FROM golang:1.9.0
EXPOSE 8050
RUN mkdir -p /go/src/hello-compsci/code-director/codedirector
WORKDIR /go/src/hello-compsci/code-director
COPY . .
RUN CGO_ENABLED=0 go build -o main

# Final container to run service
FROM scratch
COPY --from=0 /go/src/hello-compsci/code-director/main .
ENTRYPOINT ["./main"]