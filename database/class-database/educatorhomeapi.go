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

// getEducatorHomeInfo should be the first endpoint accessed when the educator home page is loaded.
// This will send a response that contains a protobuf marshalled EducatorHomeData struct
func (s *Server) getEducatorHomeInfo(w http.ResponseWriter, req *http.Request) {
	educatorHomeData := &pb.EducatorHomeData{}
	// Unmarshal request
	educatorHomeReq := s.getEdHomeReqInfoFromReq(req)
	if educatorHomeReq == nil {
		return
	}

	// Check that the session has permission to access this information
	if !s.sessionHasAccessToClass(educatorHomeReq.SessionGUID, educatorHomeReq.ClassName) {
		educatorHomeData.Message = "Permission denied."
		sendPB(educatorHomeData, w)
		return
	}

	s.prepareEdHomeDataResponse(educatorHomeData, educatorHomeReq)

	// Send response
	sendPB(educatorHomeData, w)
}

func (s *Server) getEdHomeReqInfoFromReq(req *http.Request) *pb.EducatorHomeDataRequest {
	// get the NewClassReq struct
	educatorHomeReq := &pb.EducatorHomeDataRequest{}
	rawData, err := ioutil.ReadAll(req.Body)
	if err != nil {
		fmt.Println(err.Error())
		return nil
	}
	if err = proto.Unmarshal(rawData, educatorHomeReq); err != nil {
		fmt.Println(err.Error())
		return nil
	}
	return educatorHomeReq
}

func (s *Server) sessionHasAccessToClass(sessionGUID, className string) bool {
	// get session
	session := s.classDB.GetSession(sessionGUID)
	if session == nil {
		fmt.Println("sessionHasAccessToClass: session not found in DB")
		return false
	}

	// Check if there is a classNameStorage with a matching className
	for _, classNameStorage := range session.ClassNames {
		if classNameStorage.ClassName == className {
			return true
		}
	}

	return false
}

func (s *Server) prepareEdHomeDataResponse(edHomeData *pb.EducatorHomeData, edHomeDataReq *pb.EducatorHomeDataRequest) error {
	edHomeData.ClassName = edHomeDataReq.ClassName

	// get class
	var destinationClass data.Class
	if exists := destinationClass.PopulateFromDB(&s.classDB.Database, edHomeData.ClassName); !exists {
		return fmt.Errorf("class not found")
	}
	destinationClass.PopulateRelatedFields(&s.classDB.Database)

	s.storeProblemIDsAndTitles(edHomeData, &destinationClass)

	// current problem
	if destinationClass.CurrentProblemIndex >= 0 {
		edHomeData.CurrentProblem = destinationClass.Problems[destinationClass.CurrentProblemIndex].ToPBStruct()
	}
	edHomeData.Success = true
	return nil
}

func (s *Server) storeProblemIDsAndTitles(edHomeData *pb.EducatorHomeData, class *data.Class) {
	edHomeData.ProblemIDs = make([]uint64, 0, len(class.Problems))
	edHomeData.ProblemTitles = make([]string, 0, len(class.Problems))
	for _, problem := range class.Problems {
		edHomeData.ProblemIDs = append(edHomeData.ProblemIDs, uint64(problem.ID))
		edHomeData.ProblemTitles = append(edHomeData.ProblemTitles, problem.Title)
	}
}
