// Copyright (C) 2017  Nicholas Anderssohn

package cdb // stands for class database
import (
	"hello-compsci/database/data"
	"net/http"
	"strconv"
)

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
	http.HandleFunc("/createclass", s.createNewClassHandler)
	http.ListenAndServe(":"+strconv.Itoa(s.port), nil)
}

func (s *Server) createNewClassHandler(w http.ResponseWriter, req *http.Request) {
	defer req.Body.Close()
	s.formCreateClassResponseHeader(w, req)
	// browsers will first send a request of type OPTIONS to verify that they are okay to send
	// whatever request they are trying to send
	if req.Method == "OPTIONS" {
		// TODO: potentially should check if req will be malformed
		w.WriteHeader(http.StatusOK)
	} else if req.Method == "POST" {
		s.createNewClass(w, req)
	}
}

func (s *Server) formCreateClassResponseHeader(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Access-Control-Allow-Origin", req.Header.Get("Origin"))
	w.Header().Add("Access-Control-Allow-Methods", "POST")
	w.Header().Add("Access-Control-Allow-Headers", "ClassName")
	w.Header().Add("Access-Control-Allow-Headers", "Email")
	w.Header().Add("Access-Control-Allow-Headers", "Password")
	w.Header().Add("Access-Control-Allow-Headers", "CreateSuccess")
	w.Header().Add("Access-Control-Allow-Headers", "SessionGUID")
}

// createNewClass creates a new class if it doesn't exist.
// Its response sends back a bool indicating if it was able to create the class.
// The response also contains a session guid if it was successful when creating the class.
func (s *Server) createNewClass(w http.ResponseWriter, req *http.Request) {
	// Prepare the response by setting the header
	s.formCreateClassResponseHeader(w, req)

	// Get values from header
	className := req.Header["ClassName"][0]
	email := req.Header["Email"][0]
	password := req.Header["Password"][0]

	// Check if class already exists
	if s.classDB.ClassExists(className) {
		w.Header().Add("CreateSuccess", "false")
		w.Write(nil)
		return
	}

	// Create new class
	s.classDB.AddNewClass(className, email, password)

	// Add the class to a session
	var session *data.Session

	// Grab existing session if req has one
	if sessionGUIDSlice, found := req.Header["SessionGUID"]; found && len(sessionGUIDSlice) > 0 {
		session = s.classDB.GetSession(sessionGUIDSlice[0])
	}

	// session is nil if no existing one was found
	if session == nil {
		session = s.classDB.CreateNewSessionInDB(className)
	} else {
		s.classDB.Save(session)
	}

	w.Header().Add("CreateSuccess", "true")
	w.Header().Add("SessionGUID", session.SessionGUID)
	w.WriteHeader(http.StatusOK)
}
