// Copyright (C) 2017  Nicholas Anderssohn

package cdb

import (
	"fmt"
	"hello-compsci/database/pb"
	"io/ioutil"
	"net/http"

	"github.com/golang/protobuf/proto"
)

func (s *Server) handleRequestLogin(w http.ResponseWriter, req *http.Request) {
	loginReq := s.unmarshallLoginReq(req)
	if loginReq == nil {
		return
	}

	loginResp := &pb.LoginResponse{ClassName: loginReq.ClassName}

	// check if password and class match
	// if so add to guid
	if s.classDB.PasswordMatchesClassName(loginReq.ClassName, loginReq.Password) {
		session := s.classDB.GetSession(loginReq.SessionGUID)
		if session == nil {
			session = s.classDB.CreateNewSessionInDB(loginReq.ClassName)
		}
		fmt.Println("sesh: ", session.SessionGUID)
		loginResp.SessionGUID = session.SessionGUID
		if !session.ContainsClass(loginReq.ClassName) {
			session.AppendClassName(loginReq.ClassName)
		}
		loginResp.Success = true
	} else {
		loginResp.Message = "Incorrect password."
	}
	sendPB(loginResp, w)
}

func (s *Server) unmarshallLoginReq(req *http.Request) *pb.LoginRequest {
	loginRequest := &pb.LoginRequest{}
	rawData, err := ioutil.ReadAll(req.Body)
	if err != nil {
		fmt.Println(err.Error())
		return nil
	}
	if err = proto.Unmarshal(rawData, loginRequest); err != nil {
		fmt.Println(err.Error())
		return nil
	}
	return loginRequest
}
