// Copyright (C) 2017  Nicholas Anderssohn

package data

import (
	"hello-compsci/database/database"
	"hello-compsci/database/pb"

	"github.com/jinzhu/gorm"
)

// Setting stores the name and whether or not it is selected of a setting
type Setting struct {
	gorm.Model
	Name       string
	IsSelected bool
	ProblemID  int
}

// Problem contains information related to an individual problem
type Problem struct {
	gorm.Model
	Title       string
	Prompt      string
	Submissions []Submission
	Settings    []Setting
	ClassID     int
}

// PopulateRelatedFields uses the database to populate related fields such as Submissions and Settings
func (p *Problem) PopulateRelatedFields(db *database.Database) {
	db.DB.Model(p).Related(&p.Settings)
	db.DB.Model(p).Related(&p.Submissions)
}

func (p *Problem) ToPBStruct() *pb.Problem {
	pbProblem := &pb.Problem{
		Id:          uint64(p.ID),
		Title:       p.Title,
		Prompt:      p.Prompt,
		Success:     true,
		Submissions: make([]*pb.Submission, 0, len(p.Submissions)),
		Settings:    make([]*pb.Setting, 0, len(p.Settings)),
	}
	//submissions
	for _, sub := range p.Submissions {
		pbProblem.Submissions = append(pbProblem.Submissions, sub.ToPBStruct())
	}

	//settings
	for _, setting := range p.Settings {
		pbProblem.Settings = append(pbProblem.Settings, setting.ToPBStruct())
	}
	return pbProblem
}

func (s *Setting) ToPBStruct() *pb.Setting {
	return &pb.Setting{
		Name:       s.Name,
		IsSelected: s.IsSelected,
		Success:    true,
		Id:         uint64(s.ID),
	}
}
