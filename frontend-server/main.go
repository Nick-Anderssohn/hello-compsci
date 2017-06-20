// Copyright (C) 2017  Nicholas Anderssohn
package main

import (
	"context"
	"fmt"
	"hello-class/frontend-server/director"
	"hello-class/frontend-server/rest"
	"net/http"
)

func main() {
	endpoints := []*rest.Endpoint{
		&rest.Endpoint{
			Path:        "/",
			HandlerFunc: http.FileServer(http.Dir("client/build/web")),
		},
	}

	server := director.NewHelloClassServer(context.Background(), endpoints, "", "80")
	if err := server.Run(); err != nil {
		fmt.Println(err.Error())
	}
}
