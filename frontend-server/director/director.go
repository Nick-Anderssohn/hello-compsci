// Copyright (C) 2017  Nicholas Anderssohn

// Package director extends rest's functionality by keeping track of sessions and
// ports for hello class
package director

import (
	"context"
	"hello-compsci/frontend-server/rest"
	"net/http/httputil"
	"net/url"
)

const (
	playPath   = "/runcode"
	createPath = "/createclass"
)

// HelloClassServer is specifically for hello class. keeps track of sessions and ports
type HelloClassServer struct {
	rest.Server
}

// NewHelloClassServer returns a pointer to a HelloClassServer
func NewHelloClassServer(ctx context.Context, endpoints []*rest.Endpoint, address string, port string) *HelloClassServer {
	server := &HelloClassServer{}
	codeDirectorURL, _ := url.Parse("http://code-director:8050")
	createURL, _ := url.Parse("http://hc-database:8078/createclass")
	endpoints = append(
		endpoints,
		&rest.Endpoint{
			Path:        playPath,
			HandlerFunc: httputil.NewSingleHostReverseProxy(codeDirectorURL),
		},
		&rest.Endpoint{
			Path:        createPath,
			HandlerFunc: httputil.NewSingleHostReverseProxy(createURL),
		})
	server.Server = *rest.NewServer(ctx, endpoints, address, port)
	return server
}
