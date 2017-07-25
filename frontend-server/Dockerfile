# intermediate container used to build the dart/scss code
FROM nickanderssohn/dart-sass:1.0

# Copy project over
RUN mkdir /client
WORKDIR /client
COPY ./client .

# build dart
RUN pub get
RUN pub build
RUN cp -R build/web/packages/codemirror build/web/play/packages/
RUN cp -R build/web/packages/codemirror build/web/question/packages/

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
