// Copyright (C) 2017  Nicholas Anderssohn

package data

import "github.com/jinzhu/gorm"

// Class contains information related to a class.
type Class struct {
	gorm.Model
	ClassName string `gorm:"primary_key"`
	Email     string
	Password  []byte // Use md5 to hash
	Problems  []Problem
}
