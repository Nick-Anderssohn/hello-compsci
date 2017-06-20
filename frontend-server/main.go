// Copyright (C) 2017  Nicholas Anderssohn
package main

import (
	"context"
	"hello-class/frontend-server/director"
	"hello-class/frontend-server/rest"
	"net/http"
)

func main() {
	endpoints := []*rest.Endpoint{
		&rest.Endpoint{
			Path:        "/",
			HandlerFunc: http.FileServer(http.Dir("../client/build/web")),
		},
	}

	server := director.NewHelloClassServer(context.Background(), endpoints, "", "8080")
	server.Run()
}
