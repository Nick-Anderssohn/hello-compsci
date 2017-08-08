// Copyright (C) 2017  Nicholas Anderssohn

package data

import "github.com/jinzhu/gorm"

// Setting stores the name and whether or not it is selected of a setting
type Setting struct {
	gorm.Model
	Name       string
	IsSelected bool
	ProblemID  int
}

// Problem contains information related to an individual problem
type Problem struct {
	gorm.Model
	Title       string
	Prompt      string
	Submissions []Submission
	Settings    []Setting
	ClassID     int
}