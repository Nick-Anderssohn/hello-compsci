// Copyright (C) 2017  Nicholas Anderssohn

package data

import (
	"hello-class/database/database"

	"github.com/jinzhu/gorm"
)

// Class contains information related to a class.
type Class struct {
	gorm.Model
	ClassName string `gorm:"primary_key"`
	Email     string
	Password  []byte // use bcrypt
	Problems  []Problem
}

// PopulateFromDB accepts a database and className. It tries to populate this struct by grabbing the data from
// the database based off of className. It returns a bool indicating if it succeeded.
// This does NOT populate related fields such as the Problems fields
func (c *Class) PopulateFromDB(db *database.Database, className string) (existsInDB bool) {
	db.DB.First(c, "class_name = ?", className)
	return c.ClassName == className
}

// PopulateRelatedFields uses the database to populate related fields such as Problems
func (c *Class) PopulateRelatedFields(db *database.Database) {
	db.DB.Model(c).Related(&c.Problems)
	for i := range c.Problems {
		c.Problems[i].PopulateRelatedFields(db)
	}
}
