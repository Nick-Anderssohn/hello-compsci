#  Copyright (C) 2017  Nicholas Anderssohn

# Intermediate container to build service
FROM golang:1.9.0
RUN mkdir -p /go/src/hello-compsci/database
WORKDIR /go/src/hello-compsci/database
RUN go get "github.com/beevik/guid"
RUN go get "github.com/jinzhu/gorm"
RUN go get "golang.org/x/crypto/bcrypt"
RUN go get "github.com/lib/pq"
RUN go get "github.com/lib/pq/hstore"
RUN go get "github.com/golang/protobuf/proto"
COPY . .
RUN CGO_ENABLED=0 go build -o hcdatabase

# Final container to run service
FROM scratch
COPY --from=0 /go/src/hello-compsci/database/hcdatabase .
ENTRYPOINT ["./hcdatabase"]