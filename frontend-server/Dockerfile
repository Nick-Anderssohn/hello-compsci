FROM golang:1.8.3-alpine
EXPOSE 8080
EXPOSE 8079
WORKDIR /go/src
RUN apk add --update curl
RUN rm -rf /var/cache/apk/*
RUN mkdir hello-class
RUN mkdir hello-class/frontend-server
WORKDIR /go/src/hello-class/frontend-server
COPY . .
RUN go install
WORKDIR /go/src/hello-class/frontend-server/client
RUN rm -rf lib && rm -rf web && rm pubspec.lock pubspec.yaml build.sh
RUN rm ../Dockerfile
WORKDIR /go/src/hello-class/frontend-server
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
CMD frontend-server
