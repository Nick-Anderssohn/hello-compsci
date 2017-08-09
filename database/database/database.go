// Copyright (C) 2017  Nicholas Anderssohn

package database

import (
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres" // must have this blank import
)

// Database will control the gorm database
type Database struct {
	address string
	DB      *gorm.DB
}

// NewDatabase returns a new Database struct
func NewDatabase(address string) *Database {
	return &Database{
		address: address,
	}
}

// Open connects to the database
func (d *Database) Open() (err error) {
	d.DB, err = gorm.Open("postgres", d.address)
	return
}

// Close closes the connection to the database
func (d *Database) Close() {
	d.DB.Close()
}

// GetClass returns the class corresponding to className and a bool indicating if it exists
// func (d *Database) GetClass(className string) (class *data.Class, exists bool) {
// 	class = &data.Class{}
// 	d.DB.First(class, "class_name = ?", className)
// 	return class, class.ClassName == className
// }

// // PopulateProblems accepts a class that has already been grabbed from the database, and populates
// // its Problems field with the corresponding problems found in the database
// func (d *Database) PopulateProblems(destinationClass *data.Class) {
// 	d.DB.Model(destinationClass).Related(&destinationClass.Problems) // grab the problem structs
// 	// grab the settings and submissions for each problem
// 	for i := range destinationClass.Problems {
// 		d.DB.Model(&destinationClass.Problems[i]).Related(&destinationClass.Problems[i].Settings)
// 		d.DB.Model(&destinationClass.Problems[i]).Related(&destinationClass.Problems[i].Submissions)
// 	}
// }

// Test exists to test gorm
// func Test() {
// 	const addr = "postgresql://nick@localhost:26257/helloClass?sslmode=disable"
// 	db, err := gorm.Open("postgres", addr)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	defer db.Close()

// 	testClass := data.Class{
// 		ClassName: "Test Class",
// 		Email:     "test@test.com",
// 		Password:  []byte("test"),
// 		Problems: []data.Problem{
// 			data.Problem{
// 				Title:  "Test Problem",
// 				Prompt: "Test Prompt",
// 				Settings: []data.Setting{{
// 					Name:       "Test Setting",
// 					IsSelected: true,
// 				},
// 				},
// 				Submissions: []data.Submission{
// 					data.Submission{
// 						StudentName: "Test Name",
// 						AnswerText:  "Test answer text",
// 						Graded:      true,
// 						Correct:     false,
// 					},
// 				},
// 			},
// 			data.Problem{
// 				Title:  "22222222",
// 				Prompt: "Test Prompt",
// 				Settings: []data.Setting{{
// 					Name:       "Test Setting",
// 					IsSelected: true,
// 				},
// 				},
// 				Submissions: []data.Submission{
// 					data.Submission{
// 						StudentName: "Test Name",
// 						AnswerText:  "Test answer text",
// 						Graded:      true,
// 						Correct:     false,
// 					},
// 				},
// 			},
// 		},
// 	}

// 	db.AutoMigrate(&data.Class{}, &data.Problem{}, &data.Setting{}, &data.Submission{})

// 	db.Create(&testClass) // insert a row for this class
// 	var foundTextClass data.Class

// 	db.Debug().First(&foundTextClass, "class_name = ?", "Test Class")
// 	db.Debug().Model(&foundTextClass).Related(&foundTextClass.Problems)

// 	for i := range foundTextClass.Problems {
// 		db.Debug().Model(&foundTextClass.Problems[i]).Related(&foundTextClass.Problems[i].Settings)
// 		db.Debug().Model(&foundTextClass.Problems[i]).Related(&foundTextClass.Problems[i].Submissions)
// 	}

// 	fmt.Printf("%+v\n", foundTextClass)
// }
