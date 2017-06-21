FROM golang:1.8.3-alpine
EXPOSE 8080
EXPOSE 8079
WORKDIR /go/src
RUN mkdir hello-class
RUN mkdir hello-class/frontend-server
WORKDIR /go/src/hello-class/frontend-server
COPY . .
# CMD ./frontend-server
RUN go install
WORKDIR /go/src/hello-class/frontend-server/client
RUN rm -rf lib && rm -rf web && rm pubspec.lock pubspec.yaml build.sh
RUN rm ../Dockerfile
WORKDIR /go/src/hello-class/frontend-server
CMD frontend-server
