#  Copyright (C) 2017  Nicholas Anderssohn
FROM golang:1.9.0-alpine
EXPOSE 8079
ENV JAVA_HOME=/usr/lib/jvm/default-jvm
RUN apk --update add --no-cache openjdk7 && ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/"
RUN apk add alpine-sdk
RUN apk add python3
RUN mkdir -p /go/src/hello-compsci/code-runner
WORKDIR /go/src/hello-compsci/code-runner
COPY . .
RUN go install
RUN rm -rf testfile runner common codeserver Dockerfile build.sh main.go readme.md
CMD code-runner 8079