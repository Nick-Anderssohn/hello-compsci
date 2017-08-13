// Copyright (C) 2017  Nicholas Anderssohn

// Package rest contains a basic rest server
package rest

import (
	"context"
	"fmt"
	"net/http"
	"time"
)

// Endpoint wraps a path and a handler
type Endpoint struct {
	Path        string
	HandlerFunc http.Handler
}

// Server is a basic rest server
type Server struct {
	server    *http.Server
	Endpoints []*Endpoint
	Context   context.Context
	Address   string
	Port      string
}

// NewServer returns a new server with the endpoints setup to be handled
func NewServer(ctx context.Context, endpoints []*Endpoint, address string, port string) *Server {
	server := &Server{
		server: &http.Server{
			Addr: address + ":" + port,
		},
		Endpoints: endpoints,
		Address:   address,
		Port:      port,
	}

	for _, endpoint := range endpoints {
		http.Handle(endpoint.Path, endpoint.HandlerFunc)
	}

	return server
}

// Run runs the server on address:port
func (s *Server) Run() error {
	// with handler set to nil, it will use the handlers alreay setup
	// http.ListenAndServe(s.Address+":"+s.Port, nil)
	// return s.server.ListenAndServe()
	fmt.Println("use https")
	return s.server.ListenAndServeTLS("cert.pem", "key.pem")
}

// ShutDown attempts to gracefully shutdown within 5 seconds
func (s *Server) ShutDown() error {
	ctx, cancel := context.WithTimeout(s.Context, time.Duration(5000))
	defer cancel()
	return s.server.Shutdown(ctx)
}
