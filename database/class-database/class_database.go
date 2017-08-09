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
	classDB.DB.AutoMigrate(&data.Class{}, &data.Problem{}, &data.Setting{}, &data.Submission{})
}

// ClassExists returns true if there is already a class in the database with className
func (classDB *ClassDatabase) ClassExists(className string) bool {
	destinationClass := data.Class{}
	return destinationClass.PopulateFromDB(&classDB.Database, className)
}

// AddNewClass will create a new row in the database for a class with information specified by the arguments.
// The password will be hashed via bcrypt before storing in the database
func (classDB *ClassDatabase) AddNewClass(className, email, password string) error {
	if classDB.ClassExists(className) {
		return fmt.Errorf("error: class %s already exists", className)
	}
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	newClass := data.Class{
		ClassName: className,
		Email:     email,
		Password:  hashedPassword,
	}
	classDB.DB.Create(&newClass)
	return nil
}
