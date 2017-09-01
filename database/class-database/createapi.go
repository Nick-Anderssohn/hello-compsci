// Copyright (C) 2017  Nicholas Anderssohn

package cdb // stands for class database

import (
	"fmt"
	"hello-compsci/database/data"
	"hello-compsci/database/pb"
	"io/ioutil"
	"net/http"

	"github.com/golang/protobuf/proto"
)

// createNewClass creates a new class if it doesn't exist.
// Its response sends back a bool indicating if it was able to create the class.
// The response also contains a session guid if it was successful when creating the class.
func (s *Server) createNewClass(w http.ResponseWriter, req *http.Request) {
	sessionResp := &pb.SessionResp{}

	// get the NewClassReq struct
	classInfo := s.getClassInfoFromReq(req)
	if classInfo == nil {
		return
	}

	// Check if class already exists
	if s.classDB.ClassExists(classInfo.ClassName) {
		sessionResp.Message = "Class already exists."
		sendPB(sessionResp, w)
		return
	}

	// Create new class
	if err := s.classDB.AddNewClass(classInfo.ClassName, classInfo.Email, classInfo.Password); err != nil {
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
	}

	// session is nil if no existing one was found
	if session == nil {
		session = s.classDB.CreateNewSessionInDB(classInfo.ClassName)
	} else {
		session.AppendClassName(classInfo.ClassName)
		s.classDB.Save(session)
	}

	sessionResp.Success = true
	sessionResp.SessionGUID = session.SessionGUID
	sendPB(sessionResp, w)
}

func (s *Server) getClassInfoFromReq(req *http.Request) *pb.NewClassReq {
	// get the NewClassReq struct
	classInfo := &pb.NewClassReq{}
	rawData, err := ioutil.ReadAll(req.Body)
	if err != nil {
		fmt.Println(err.Error())
		return nil
	}
	if err = proto.Unmarshal(rawData, classInfo); err != nil {
		fmt.Println(err.Error())
		return nil
	}
	return classInfo
}
