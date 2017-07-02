// Copyright (C) 2017  Nicholas Anderssohn

package runner

import (
	"os/exec"
	"reflect"
	"testing"
)

func TestNewCode(t *testing.T) {
	type args struct {
		codeFile string
	}
	tests := []struct {
		name    string
		args    args
		want    *Code
		wantErr bool
	}{
		{
			"New Go Code",
			args{"testfile/testfile.go"},
			&Code{
				CompilerErrFile: "output/cErr.txt",
				OutputFile:      "output/output.txt",
				buildCMD:        "go",
				buildARGs:       []string{"build", "-o", "testfile/testfile", "testfile/testfile.go"},
				runCMD:          "./testfile/testfile",
			},
			false,
		},
		{"New Invalid Code",
			args{"testfile/testfile.monkey"},
			nil,
			true,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := NewCode(tt.args.codeFile)
			if (err != nil) != tt.wantErr {
				t.Errorf("NewCode() error = %v,\nwantErr %v", err, tt.wantErr)
				return
			}
			if !reflect.DeepEqual(got, tt.want) {
				t.Errorf("NewCode() = %v,\nwant %v", got, tt.want)
			}
		})
	}
}

func TestCode_Run(t *testing.T) {
	exec.Command("ls").Run()

	goCode, _ := NewCode("../testfile/testfile.go")
	cCode, _ := NewCode("../testfile/testfile.c")
	cppCode, _ := NewCode("../testfile/testfile.cpp")
	javaCode, _ := NewCode("../testfile/HelloWorld.java")
	pythonThreeCode, _ := NewCode("../testfile/HelloWorld.java")
	tests := []struct {
		name    string
		c       *Code
		wantErr bool
	}{
		{
			"Test BuildRun Go",
			goCode,
			false,
		},
		{
			"Test BuildRun C",
			cCode,
			false,
		},
		{
			"Test BuildRun C++",
			cppCode,
			false,
		},
		{
			"Test BuildRun Java",
			javaCode,
			false,
		},
		{
			"Test BuildRun Python3",
			pythonThreeCode,
			false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if err := tt.c.BuildRun(); (err != nil) != tt.wantErr {
				t.Errorf("Code.BuildRun() error = %v, wantErr %v", err, tt.wantErr)
			}
		})
	}
}
