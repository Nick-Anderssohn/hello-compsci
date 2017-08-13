// Copyright (C) 2017  Nicholas Anderssohn

package data

import (
	"github.com/beevik/guid"
	"github.com/jinzhu/gorm"
)

// Session is used to keep users logged in
type Session struct {
	gorm.Model
	SessionID string `gorm:"primary_key"`
	ClassName string
}

// NewSession creates a new session.
// existingClass should already be in DB
func NewSession(existingClassName string) *Session {
	id := guid.NewString()
	return &Session{
		SessionID: id,
		ClassName: existingClassName,
	}
}
