// Copyright (C) 2017  Nicholas Anderssohn

package database

import (
	"fmt"
	"hello-class/database/data"
	"log"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres" // must have this blank import
)

// Test exists to test gorm
func Test() {
	const addr = "postgresql://nick@localhost:26257/helloClass?sslmode=disable"
	db, err := gorm.Open("postgres", addr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	testClass := data.Class{
		ClassName: "Test Class",
		Email:     "test@test.com",
		Password:  []byte("test"),
		Problems: []data.Problem{
			data.Problem{
				Title:  "Test Problem",
				Prompt: "Test Prompt",
				Settings: []data.Setting{{
					Name:       "Test Setting",
					IsSelected: true,
				},
				},
				Submissions: []data.Submission{
					data.Submission{
						StudentName: "Test Name",
						AnswerText:  "Test answer text",
						Graded:      true,
						Correct:     false,
					},
				},
			},
			data.Problem{
				Title:  "22222222",
				Prompt: "Test Prompt",
				Settings: []data.Setting{{
					Name:       "Test Setting",
					IsSelected: true,
				},
				},
				Submissions: []data.Submission{
					data.Submission{
						StudentName: "Test Name",
						AnswerText:  "Test answer text",
						Graded:      true,
						Correct:     false,
					},
				},
			},
		},
	}

	db.AutoMigrate(&data.Class{}, &data.Problem{}, &data.Setting{}, &data.Submission{})

	db.Create(&testClass) // insert a row for this class
	var foundTextClass data.Class

	db.Debug().First(&foundTextClass, "class_name = ?", "Test Class")
	db.Debug().Model(&foundTextClass).Related(&foundTextClass.Problems)

	for i := range foundTextClass.Problems {
		db.Debug().Model(&foundTextClass.Problems[i]).Related(&foundTextClass.Problems[i].Settings)
		db.Debug().Model(&foundTextClass.Problems[i]).Related(&foundTextClass.Problems[i].Submissions)
	}

	fmt.Printf("%+v\n", foundTextClass)
}
