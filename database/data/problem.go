// Copyright (C) 2017  Nicholas Anderssohn

package data

import "github.com/jinzhu/gorm"

// Setting stores the name and whether or not it is selected of a setting
type Setting struct {
	Name       string
	IsSelected bool
}

// Problem contains information related to an individual problem
type Problem struct {
	gorm.Model
	ClassName   string
	Title       string
	Prompt      string
	Submissions []Submission
	Settings    []Setting
}
