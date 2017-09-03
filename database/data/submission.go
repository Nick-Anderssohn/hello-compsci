// Copyright (C) 2017  Nicholas Anderssohn

package data

import (
	"hello-compsci/database/pb"

	"github.com/jinzhu/gorm"
)

// Submission stores the information related to a student submission
type Submission struct {
	gorm.Model
	StudentName string
	AnswerText  string
	Graded      bool
	Correct     bool
	ProblemID   int
}

// NewSubmissionFromPBStruct creates a new Submission from the protobuf version.
// Note: This does NOT set ProblemID
func NewSubmissionFromPBStruct(pbSubmission *pb.Submission) *Submission {
	return &Submission{
		StudentName: pbSubmission.StudentName,
		AnswerText:  pbSubmission.AnswerText,
		Graded:      pbSubmission.Graded,
		Correct:     pbSubmission.Correct,
		//ProblemID:   int(pbSubmission.ProblemID),
	}
}

func (s *Submission) ToPBStruct() *pb.Submission {
	return &pb.Submission{
		StudentName: s.StudentName,
		AnswerText:  s.AnswerText,
		Graded:      s.Graded,
		Correct:     s.Correct,
		Success:     true,
		Id:          uint64(s.ID),
	}
}
