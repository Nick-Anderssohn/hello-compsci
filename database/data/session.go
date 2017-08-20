// Copyright (C) 2017  Nicholas Anderssohn

package data

import (
	"hello-compsci/database/database"

	"github.com/beevik/guid"
	"github.com/jinzhu/gorm"
)

// ClassNameStorage stores a single class name
// Postgres does not support []string, so we use a []ClassNameStorage instead
type ClassNameStorage struct {
	gorm.Model
	ClassName string
	SessionID int
}

// Session is used to keep users logged in
type Session struct {
	gorm.Model
	SessionGUID string // `gorm:"primary_key"`
	ClassNames  []ClassNameStorage
}

// NewSession creates a new session.
// existingClass should already be in DB
func NewSession(existingClassName string) *Session {
	id := guid.NewString()
	return &Session{
		SessionGUID: id,
		ClassNames:  []ClassNameStorage{ClassNameStorage{ClassName: existingClassName}},
	}
}

// PopulateRelatedFields uses the database to populate related fields such as Problems
func (s *Session) PopulateRelatedFields(db *database.Database) {
	db.DB.Model(s).Related(&s.ClassNames)
}
