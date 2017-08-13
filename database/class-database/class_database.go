// Copyright (C) 2017  Nicholas Anderssohn

package cdb // stands for class database

import (
	"fmt"
	"hello-class/database/data"
	"hello-class/database/database"

	"golang.org/x/crypto/bcrypt"
)

// ClassDatabase offers specific database functionality for the structs found in the data package
type ClassDatabase struct {
	database.Database
}

// NewClassDatabase returns a new ClassDatabase
func NewClassDatabase() *ClassDatabase {
	return &ClassDatabase{
		Database: *database.NewDatabase("postgresql://nick@localhost:26257/helloClass?sslmode=disable"),
	}
}

// Start opens the database and automigrates the class struct, problem struct, settings struct, and submissions struct
func (classDB *ClassDatabase) Start() {
	classDB.Open()
	classDB.DB.AutoMigrate(&data.Session{}, &data.Class{}, &data.Problem{}, &data.Setting{}, &data.Submission{})
}

// ClassExists returns true if there is already a class in the database with className
func (classDB *ClassDatabase) ClassExists(className string) bool {
	var destinationClass data.Class
	return destinationClass.PopulateFromDB(&classDB.Database, className)
}

// AddNewClass will create a new row in the database for a class with information specified by the arguments.
// The password will be hashed via bcrypt before storing in the database
// This will also create a new session and return it
func (classDB *ClassDatabase) AddNewClass(className, email, password string) (*data.Session, error) {
	// Make sure the class does not already exist
	if classDB.ClassExists(className) {
		return nil, fmt.Errorf("error: class %s already exists", className)
	}

	// Use bcrypt to create a hash of the password
	// Automatically creates a good salt for you!
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}

	// Create a new class
	newClass := data.Class{
		ClassName: className,
		Email:     email,
		Password:  hashedPassword,
	}

	classDB.DB.Create(&newClass)

	newSession := classDB.CreateNewSessionInDB(className)

	return newSession, nil
}

// CreateNewSessionInDB creates a session and ensure there is not already a session with the same ID.
// It then adds it to the database
func (classDB *ClassDatabase) CreateNewSessionInDB(className string) *data.Session {
	// Create a session and ensure there is not already a session with the same ID
	newSession := data.NewSession(className)
	for ; classDB.SessionExists(newSession.SessionID); newSession = data.NewSession(className) {
	}

	classDB.DB.Create(newSession)
	return newSession
}

// GetSession returns returns the session that corresponds to sessionID or nil if it is not found
func (classDB *ClassDatabase) GetSession(sessionID string) *data.Session {
	var destinationSession data.Session
	classDB.DB.First(&destinationSession, "session_id = ?", sessionID)
	if destinationSession.SessionID == sessionID {
		return &destinationSession
	}
	return nil
}

// SessionExists returns true if their is a session in the database with the corresponding sessionID
func (classDB *ClassDatabase) SessionExists(sessionID string) bool {
	return classDB.GetSession(sessionID) != nil
}
