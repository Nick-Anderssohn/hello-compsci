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

// NewProblemFromPBStruct creates a new Problem from the protobuf version.
// Note: This does NOT populate the ClassID field
func NewProblemFromPBStruct(pbProblem *pb.Problem) *Problem {
	submissions := make([]Submission, 0)
	for _, submission := range pbProblem.Submissions {
		submissions = append(submissions, *NewSubmissionFromPBStruct(submission))
	}

	settings := make([]Setting, 0)
	for _, setting := range pbProblem.Settings {
		settings = append(settings, *NewSettingFromPBStruct(setting))
	}

	return &Problem{
		Title:       pbProblem.Title,
		Prompt:      pbProblem.Prompt,
		Submissions: submissions,
		Settings:    settings,
	}
}

func NewSettingFromPBStruct(pbSetting *pb.Setting) *Setting {
	return &Setting{
		Name:       pbSetting.Name,
		IsSelected: pbSetting.IsSelected,
	}
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
