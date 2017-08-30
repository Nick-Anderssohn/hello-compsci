// Copyright (C) 2017  Nicholas Anderssohn

package cdb // stands for class database
import (
	"fmt"
	"net/http"
	"strconv"

	"github.com/golang/protobuf/proto"
)

const commandKey = "Command"

// Server offers a REST API for accessing a class database
type Server struct {
	classDB *ClassDatabase
	port    int
}

// NewServer creates a server with along with a fresh ClassDatabse
func NewServer(port int) *Server {
	return &Server{classDB: NewClassDatabase(), port: port}
}

// Run opens a connection to the database and starts the server for the REST api
func (s *Server) Run() {
	s.classDB.Start()
	http.HandleFunc("/", s.handleCommand)
	http.ListenAndServe(":"+strconv.Itoa(s.port), nil)
}

func (s *Server) handleCommand(w http.ResponseWriter, req *http.Request) {
	defer req.Body.Close()
	s.formCreateClassResponseHeader(w, req)
	// browsers will first send a request of type OPTIONS to verify that they are okay to send
	// whatever request they are trying to send
	if req.Method == "OPTIONS" {
		// TODO: potentially should check if req will be malformed
		w.WriteHeader(http.StatusOK)
	} else if req.Method == "POST" {
		switch req.Header.Get(commandKey) {
		case "CreateClass":
			s.createNewClass(w, req)
		case "GetEdHomeInfo":
			s.getEducatorHomeInfo(w, req)
		}
	}
}

func (s *Server) formCreateClassResponseHeader(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Access-Control-Allow-Origin", req.Header.Get("Origin"))
	w.Header().Add("Access-Control-Allow-Methods", "POST")
	w.Header().Add("Access-Control-Allow-Headers", commandKey)
}

func sendPB(protoStruct proto.Message, w http.ResponseWriter) {
	marshalledResp, err := proto.Marshal(protoStruct)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	w.Write(marshalledResp)
}
