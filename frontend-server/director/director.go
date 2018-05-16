// Copyright (C) 2017  Nicholas Anderssohn

// Package director extends rest's functionality by keeping track of sessions and
// ports for hello class
package director

import (
	"context"
	"hello-compsci/frontend-server/server"
	"net/http/httputil"
	"net/url"
)

const (
	playPath     = "/runcode"
	databasePath = "/database"
)

// HelloClassServer is specifically for hello class. keeps track of sessions and ports
type HelloClassServer struct {
	server.Server
}

// NewHelloClassServer returns a pointer to a HelloClassServer
func NewHelloClassServer(ctx context.Context, endpoints []*server.Endpoint, address string, port string) *HelloClassServer {
	hcServer := &HelloClassServer{}
	codeDirectorURL, _ := url.Parse("http://code-director:8050")
	databaseURL, _ := url.Parse("http://hc-database:8078/database")
	endpoints = append(
		endpoints,
		&server.Endpoint{
			Path:        playPath,
			HandlerFunc: httputil.NewSingleHostReverseProxy(codeDirectorURL),
		},
		&server.Endpoint{
			Path:        databasePath,
			HandlerFunc: httputil.NewSingleHostReverseProxy(databaseURL),
		})
	hcServer.Server = *server.NewServer(ctx, endpoints, address, port)
	return hcServer
}
