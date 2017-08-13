// Copyright (C) 2017  Nicholas Anderssohn

package main

import (
	"fmt"
	"hello-class/database/class-database"
	"hello-class/database/data"

	"golang.org/x/crypto/bcrypt"
)

// var testClass = data.Class{
// 	ClassName: "Test Class",
// 	Email:     "test@test.com",
// 	Password:  []byte("test"),
// 	Problems: []data.Problem{
// 		data.Problem{
// 			Title:  "Test Problem",
// 			Prompt: "Test Prompt",
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
// 		data.Problem{
// 			Title:  "22222222",
// 			Prompt: "Test Prompt",
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

func main() {
	// ********** Testing ***************
	classDB := cdb.NewClassDatabase()
	classDB.Start()
	defer classDB.Close()
	fmt.Println("adding new class...")
	session, err := classDB.AddNewClass("Gopher class", "test@test.com", "test")
	if err != nil {
		fmt.Println(err.Error())
	}
	var foundClass data.Class
	if classDB.ClassExists("Gopher class") {
		foundClass.PopulateFromDB(&classDB.Database, "Gopher class")
		fmt.Printf("%+v\n", foundClass)
		if err = bcrypt.CompareHashAndPassword(foundClass.Password, []byte("test")); err != nil {
			fmt.Println("passwords do not match!")
		} else {
			fmt.Println("passwords match!")
		}
	} else {
		fmt.Println("could not find class")
	}
	// **********************************
	foundSession := classDB.GetSession(session.SessionID)
	fmt.Printf("foundSession: %+v\n", foundSession)
}
