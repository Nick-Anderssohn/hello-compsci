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
