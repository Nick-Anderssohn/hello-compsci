// Copyright (C) 2017  Nicholas Anderssohn

package data

import (
	"github.com/jinzhu/gorm"
)

// Submission stores the information related to a student submission
type Submission struct {
	gorm.Model
	StudentName string
	AnswerText  string
	Graded      bool
	Correct     bool
}
