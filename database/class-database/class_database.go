// Copyright (C) 2017  Nicholas Anderssohn

package cdb // stands for class database

import (
	"fmt"
	"hello-compsci/database/data"
	"hello-compsci/database/database"

	"golang.org/x/crypto/bcrypt"
)

// ClassDatabase offers specific database functionality for the structs found in the data package
type ClassDatabase struct {
	database.Database
}

// NewClassDatabase returns a new ClassDatabase
func NewClassDatabase() *ClassDatabase {
	return &ClassDatabase{
		Database: *database.NewDatabase("postgresql://nick@hcroach:26257/helloCompSci?sslmode=disable"),
	}
}

// Start opens the database and automigrates the class struct, problem struct, settings struct, and submissions struct
func (classDB *ClassDatabase) Start() {
	if err := classDB.Open(); err != nil {
		fmt.Println("classDB Start(): ", err.Error())
		return
	}
	classDB.DB.AutoMigrate(&data.Session{}, &data.Class{}, &data.Problem{}, &data.Setting{}, &data.Submission{}, &data.ClassNameStorage{})
}

// ClassExists returns true if there is already a class in the database with className
func (classDB *ClassDatabase) ClassExists(className string) bool {
	var destinationClass data.Class
	return destinationClass.PopulateFromDB(&classDB.Database, className)
}

// AddNewClass will create a new row in the database for a class with information specified by the arguments.
// The password will be hashed via bcrypt before storing in the database
func (classDB *ClassDatabase) AddNewClass(className, email, password string) error {
	// Make sure the class does not already exist
	if classDB.ClassExists(className) {
		return fmt.Errorf("error: class %s already exists", className)
	}

	// Use bcrypt to create a hash of the password
	// Automatically creates a good salt for you!
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	// Create a new class
	newClass := data.Class{
		ClassName:           className,
		Email:               email,
		Password:            hashedPassword,
		CurrentProblemIndex: -1,
	}

	classDB.DB.Create(&newClass)

	return nil
}

// CreateNewSessionInDB creates a session and ensure there is not already a session with the same ID.
// It then adds it to the database
func (classDB *ClassDatabase) CreateNewSessionInDB(className string) *data.Session {
	// Create a session and ensure there is not already a session with the same ID
	newSession := data.NewSession(className)
	for ; classDB.SessionExists(newSession.SessionGUID); newSession = data.NewSession(className) {
	}

	classDB.DB.Create(newSession)
	return newSession
}

// GetSession returns the session that corresponds to sessionGUID or nil if it is not found
func (classDB *ClassDatabase) GetSession(sessionGUID string) *data.Session {
	if sessionGUID == "" {
		return nil
	}

	var destinationSession data.Session
	classDB.DB.First(&destinationSession, "session_guid = ?", sessionGUID)
	if destinationSession.SessionGUID == sessionGUID {
		destinationSession.PopulateRelatedFields(&classDB.Database)
		return &destinationSession
	}
	return nil
}

// SessionExists returns true if their is a session in the database with the corresponding sessionID
func (classDB *ClassDatabase) SessionExists(sessionID string) bool {
	return classDB.GetSession(sessionID) != nil
}

// Save updates assumes obj is already in the database and updates it.
func (classDB *ClassDatabase) Save(obj interface{}) {
	classDB.DB.Save(obj)
}

func (classDB *ClassDatabase) PasswordMatchesClassName(className, password string) bool {
	class := &data.Class{}
	class.PopulateFromDB(&classDB.Database, className)
	return bcrypt.CompareHashAndPassword(class.Password, []byte(password)) == nil
}
