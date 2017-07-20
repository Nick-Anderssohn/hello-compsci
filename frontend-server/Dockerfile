# intermediate container used to build the dart/scss code
FROM google/dart:1.24.2

# install ruby and its dependencies
RUN apt-get update
RUN apt-get install -y ruby-full
RUN apt-get install -y build-essential bison openssl libreadline6\
 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev\
 libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake\
 libtool

#install sass
RUN gem install sass --no-user-install

# Copy project over
RUN mkdir /client
WORKDIR /client
COPY ./client .

# build dart
RUN pub get
RUN ./build.sh

# The final container
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
RUN rm -rf client && mkdir client && mkdir client/build
# copy the version that was compiled in the intermediate container
COPY --from=0 /client/build ./client/build
RUN go install
WORKDIR /go/src/hello-class/frontend-server/client
WORKDIR /go/src/hello-class/frontend-server
RUN rm Dockerfile
HEALTHCHECK CMD curl --fail http://localhost:8080/ || exit 1
CMD frontend-server
