// Copyright (C) 2017  Nicholas Anderssohn
package codeserver

import (
	"hello-class/code-runner/runner"
	"io/ioutil"
	"log"
	"net/http"
	"strconv"
)

// Server is a server that can receive code, run it, and respond with the output
type Server struct {
	code     *runner.Code
	codeFile string
	logger   *log.Logger
	port     int
}

// NewServer instantiates logger and returns a new CodeServer
func NewServer(logger *log.Logger, port int) *Server {
	return &Server{
		logger: logger,
		port:   port,
	}
}

// Run starts the server on 0.0.0.0
func (cs *Server) Run() {
	http.HandleFunc("/", cs.handler)
	http.HandleFunc("/healthcheck", HealthCheck)
	http.ListenAndServe(":"+strconv.Itoa(cs.port), nil)
}

func (cs *Server) handler(w http.ResponseWriter, req *http.Request) {
	defer req.Body.Close()

	// browsers will first send a request of type OPTIONS to verify that they are okay to send
	// whatever request they are trying to send
	if req.Method == "OPTIONS" {
		cs.handleOptions(w, req)
	} else if req.Method == "POST" {
		cs.handlePost(w, req)
	}
}

func (cs *Server) handleOptions(w http.ResponseWriter, req *http.Request) {
	cs.formResponseHeader(w, req)
	// TODO: potentially should check if req will be malformed
	w.WriteHeader(http.StatusOK)
}

func (cs *Server) formResponseHeader(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Access-Control-Allow-Origin", req.Header.Get("Origin"))
	w.Header().Add("Access-Control-Allow-Methods", "POST")
	w.Header().Add("Access-Control-Allow-Headers", "Filename")
}

func (cs *Server) handlePost(w http.ResponseWriter, req *http.Request) {
	cs.formResponseHeader(w, req)

	// get the name of the to-be code file
	cs.codeFile = "output/" + req.Header.Get("Filename")

	// read the body of the request
	body, err := ioutil.ReadAll(req.Body)

	if err != nil {
		cs.logger.Printf("handler/%v\n", err.Error())
		return
	}

	// write the body to a file
	if err = ioutil.WriteFile(cs.codeFile, body, 0777); err != nil {
		cs.logger.Printf("handler/%v\n", err.Error())
		return
	}

	// create a new Code struct
	if cs.code, err = runner.NewCode(cs.codeFile); err != nil {
		cs.logger.Printf("handler/%v\n", err.Error())
		return
	}

	// compile and run the code
	if err = cs.code.Run(); err != nil {
		cs.logger.Printf("handler/%v\n", err.Error())
		w.Write(cs.GetCErrOutput())
		return
	}

	w.Write(cs.GetOutput())
}

// GetCErrOutput gets the output from the build process
func (cs *Server) GetCErrOutput() (output []byte) {
	if cs.code != nil {
		output, _ = ioutil.ReadFile(cs.code.CompilerErrFile)
	}
	return
}

// GetOutput gets the output of the last code that has been ran
func (cs *Server) GetOutput() (output []byte) {
	if cs.code != nil {
		output, _ = ioutil.ReadFile(cs.code.OutputFile)
	}
	return
}

// HealthCheck tells whoever sends the req that code-runner is still alive
func HealthCheck(writer http.ResponseWriter, req *http.Request) {
	writer.Write([]byte("ok"))
}
