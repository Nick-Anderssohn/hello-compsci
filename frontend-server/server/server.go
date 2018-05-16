// Copyright (C) 2017  Nicholas Anderssohn

// Package rest contains a basic rest server
package server

import (
	"context"
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

// var certManager autocert.Manager

// func init() {
// 	certManager = autocert.Manager{
// 		Prompt:     autocert.AcceptTOS,
// 		HostPolicy: autocert.HostWhitelist("localhost"), //your domain here
// 		Cache:      autocert.DirCache("certs"),          //folder for storing certificates
// 	}
// }

// NewServer returns a new server with the endpoints setup to be handled
func NewServer(ctx context.Context, endpoints []*Endpoint, address string, port string) *Server {
	server := &Server{
		server: &http.Server{
			Addr: address + ":" + port,
			// TLSConfig: &tls.Config{
			// 	GetCertificate: certManager.GetCertificate,
			// },
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
	return s.server.ListenAndServe()
	//return s.server.ListenAndServeTLS("selfgen/cert.pem", "selfgen/key.pem")
	// return s.server.ListenAndServeTLS("", "")
}

// ShutDown attempts to gracefully shutdown within 5 seconds
func (s *Server) ShutDown() error {
	ctx, cancel := context.WithTimeout(s.Context, time.Duration(5000))
	defer cancel()
	return s.server.Shutdown(ctx)
}
