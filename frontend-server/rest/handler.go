// Copyright (C) 2017  Nicholas Anderssohn

// Package rest contains a basic rest server
package rest

import "net/http"

// Handler implements http.Handler, it is a wrapper for a single function
type Handler struct {
	handler func(http.ResponseWriter, *http.Request)
}

// NewHandler returns a new Handler
func NewHandler(handlerFunc func(http.ResponseWriter, *http.Request)) *Handler {
	return &Handler{handlerFunc}
}

// Need this function to implement the http.Handler interface
func (h Handler) ServeHTTP(writer http.ResponseWriter, req *http.Request) {
	h.handler(writer, req)
}
