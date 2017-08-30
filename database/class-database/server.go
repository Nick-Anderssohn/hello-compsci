// Copyright (C) 2017  Nicholas Anderssohn

package cdb // stands for class database
import (
	"fmt"
	"hello-compsci/database/data"
	"hello-compsci/database/pb"
	"io/ioutil"
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
		}
	}
}

func (s *Server) formCreateClassResponseHeader(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Access-Control-Allow-Origin", req.Header.Get("Origin"))
	w.Header().Add("Access-Control-Allow-Methods", "POST")
	w.Header().Add("Access-Control-Allow-Headers", commandKey)
}

// createNewClass creates a new class if it doesn't exist.
// Its response sends back a bool indicating if it was able to create the class.
// The response also contains a session guid if it was successful when creating the class.
func (s *Server) createNewClass(w http.ResponseWriter, req *http.Request) {
	// Prepare the response by setting the header
	sessionResp := &pb.SessionResp{}

	// get the NewClassReq struct
	classInfo := &pb.NewClassReq{}
	rawData, err := ioutil.ReadAll(req.Body)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	if err = proto.Unmarshal(rawData, classInfo); err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Printf("Class Info received:\n%+v\n", classInfo)

	// Check if class already exists
	if s.classDB.ClassExists(classInfo.ClassName) {
		fmt.Println("class already exists")
		sessionResp.Message = "Class already exists."
		sendPB(sessionResp, w)
		return
	}

	// Create new class
	if err = s.classDB.AddNewClass(classInfo.ClassName, classInfo.Email, classInfo.Password); err != nil {
		fmt.Println(err.Error())
		sessionResp.Message = "Database error."
		sendPB(sessionResp, w)
		return
	}

	// Add the class to a session and prepare response
	var session *data.Session

	// Grab existing session if req has one
	if sessionGUID := classInfo.SessionGUID; sessionGUID != "" {
		session = s.classDB.GetSession(sessionGUID)
		session.AppendClassName(classInfo.ClassName)
	}

	// session is nil if no existing one was found
	if session == nil {
		session = s.classDB.CreateNewSessionInDB(classInfo.ClassName)
	} else {
		s.classDB.Save(session)
	}

	sessionResp.Success = true
	sessionResp.SessionGUID = session.SessionGUID
	sendPB(sessionResp, w)
}

func sendPB(protoStruct proto.Message, w http.ResponseWriter) {
	marshalledResp, err := proto.Marshal(protoStruct)
	if err != nil {
		fmt.Println(err.Error())
		return
	}
	w.Write(marshalledResp)
}
