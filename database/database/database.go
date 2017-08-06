// Copyright (C) 2017  Nicholas Anderssohn

package database

import (
	"fmt"
	"log"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres" // must have this blank import
)

type TestEmbeded struct {
	gorm.Model
	Foo          string
	Bar          string
	TestStructId int
}

type TestStruct struct {
	gorm.Model
	Name    string `gorm:"primary_key"`
	Value   int
	FooBars []TestEmbeded
}

// Test exists to test gorm
func Test() {
	const addr = "postgresql://nick@localhost:26257/helloClass?sslmode=disable"
	db, err := gorm.Open("postgres", addr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	// testClass := data.Class{
	// 	Email:    "test@test.com",
	// 	Password: []byte("test"),
	// 	Problems: []data.Problem{
	// 		data.Problem{
	// 			ClassName: "Test Class",
	// 			Title:     "Test Problem",
	// 			Prompt:    "Test Prompt",
	// 			Settings: []data.Setting{{
	// 				Name:       "Test Setting",
	// 				IsSelected: true,
	// 			},
	// 			},
	// 			Submissions: []data.Submission{
	// 				data.Submission{
	// 					StudentName: "Test Name",
	// 					AnswerText:  "Test answer text",
	// 					Graded:      true,
	// 					Correct:     false,
	// 				},
	// 			},
	// 		},
	// 	},
	// }

	// db.AutoMigrate(&data.Class{}, &data.Problem{}, &data.Setting{}, &data.Submission{})
	// // db.AutoMigrate(&testClass)
	// db.Create(&testClass) // insert a row for this class
	// var foundTextClass data.Class
	// db.Debug().First(&foundTextClass, "class_name = ?", "Test Class").Related(&foundTextClass.Problems)
	// // db.Debug().First(&foundTextClass).Related(&foundTextClass.Problems)
	// fmt.Printf("%+v\n", foundTextClass)

	db.AutoMigrate(&TestStruct{}, &TestEmbeded{})
	test := TestStruct{
		Name:  "Test Name",
		Value: 42,
		FooBars: []TestEmbeded{
			{
				Foo: "foo",
				Bar: "bar",
			},
		},
	}
	db.Create(&test)
	var foundTest TestStruct
	db.Debug().First(&foundTest, "name = ?", "Test Name").Related(&foundTest.FooBars)
	fmt.Printf("%+v\n", foundTest)
}
