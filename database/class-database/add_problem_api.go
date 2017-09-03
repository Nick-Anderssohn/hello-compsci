// Copyright (C) 2017  Nicholas Anderssohn

package cdb

import (
	"hello-compsci/database/data"
	"hello-compsci/database/pb"
	"net/http"
)

// handle adds a problem to the database if the current session has permission to do so.
// responds with a pb.SessionResp
func (s *Server) handleAddProblemReq(w http.ResponseWriter, req *http.Request) {
	var reqProblem pb.Problem
	var sessionResp pb.SessionResp

	if ok := unmarshalPB(req, &reqProblem); !ok {
		sessionResp.Message = "Bad request."
		sendPB(&sessionResp, w)
		return
	}

	// Get the current session
	session := s.classDB.GetSession(reqProblem.SessionGUID)
	if session == nil {
		sessionResp.Message = "Session not found. Please login again."
		sendPB(&sessionResp, w)
		return
	}
	sessionResp.SessionGUID = reqProblem.SessionGUID

	// Make sure that the session has permission to modify the class
	if !session.ContainsClass(reqProblem.ClassName) {
		sessionResp.Message = "Permission denied."
		sendPB(&sessionResp, w)
		return
	}

	// Get the correct class
	var class data.Class
	class.PopulateFromDB(&s.classDB.Database, reqProblem.ClassName)
	class.PopulateRelatedFields(&s.classDB.Database)

	// Add the problem to the class
	problem := data.NewProblemFromPBStruct(&reqProblem)
	class.Problems = append(class.Problems, *problem)
	s.classDB.Save(&class)

	sessionResp.Success = true
	sendPB(&sessionResp, w)
}
