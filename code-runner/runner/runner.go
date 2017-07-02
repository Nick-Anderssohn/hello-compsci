// Copyright (C) 2017  Nicholas Anderssohn

package runner

import (
	"bytes"
	"context"
	"fmt"
	"hello-class/code-runner/common"
	"io/ioutil"
	"os/exec"
	"path/filepath"
	"strings"
	"time"
)

const runtimeLimit = 4 // seconds
var ReadyToBuildChan chan bool

// will be called right after package variables are instantiated
func init() {
	ReadyToBuildChan = make(chan bool, 1) // can hold 1
	ReadyToBuildChan <- true
}

//Code runs code files and stores output
type Code struct {
	OutputFile      string
	CompilerErrFile string
	buildCMD        string
	buildARGs       []string
	runCMD          string
	runARGs         []string
}

//NewCode returns a new Code with runCMD and buildCMD properly set
func NewCode(codeFile string) (*Code, error) {
	runCMD, runARGs := getRunCMD(codeFile)
	buildCMD, buildARGs := getBuildCMD(codeFile)

	if runCMD == "" && buildCMD == "" {
		return nil, fmt.Errorf("NewCode/Invalid filetype")
	}

	return &Code{
		CompilerErrFile: "output/cErr.txt",
		OutputFile:      "output/output.txt",
		buildCMD:        buildCMD,
		buildARGs:       buildARGs,
		runCMD:          runCMD,
		runARGs:         runARGs,
	}, nil
}
func getBuildCMD(codeFile string) (cmd string, args []string) {
	switch filepath.Ext(codeFile) {
	case ".go":
		cmd = "go"
		args = []string{"build", "-o", codeFile[:len(codeFile)-3], codeFile}
	case ".c":
		cmd = "gcc"
		args = []string{codeFile}
	case ".cpp":
		cmd = "g++"
		args = []string{codeFile}
	case ".java":
		cmd = "javac"
		args = []string{codeFile}
	}
	return
}

func getRunCMD(codeFile string) (cmd string, args []string) {
	switch filepath.Ext(codeFile) {
	case ".go":
		cmd = "./" + codeFile[:len(codeFile)-3]
		removePrevExecutable("./" + codeFile[:len(codeFile)-3])
	case ".c":
		cmd = "./a.out"
		removePrevExecutable("a.out")
	case ".cpp":
		cmd = "./a.out"
		removePrevExecutable("a.out")
	case ".java":
		cmd = "java"
		args = getJavaRunArgs(codeFile)
		removePrevExecutable(args[1] + args[2] + ".class")
	case ".py":
		cmd = "python3"
		args = []string{codeFile}
	}
	return
}

func removePrevExecutable(name string) {
	exec.Command("rm", name).Run()
}

func getJavaRunArgs(codeFile string) []string {
	tokens := strings.Split(codeFile, "/")
	var dir string
	for _, tok := range tokens[:len(tokens)-1] {
		dir += tok + "/"
	}
	fName := tokens[len(tokens)-1]
	return []string{"-cp", dir, fName[:len(fName)-5]}
}

//BuildRun builds and runs the saved code.
func (c *Code) BuildRun() (err error) {
	//<-ReadyToBuildChan // block until ready to build
	defer func() { ReadyToBuildChan <- true }()

	//build
	buildCMD := exec.Command(c.buildCMD, c.buildARGs...)
	var buildOut bytes.Buffer
	buildCMD.Stderr = &buildOut
	buildCMD.Run()

	//write output to file
	if err = ioutil.WriteFile(c.CompilerErrFile, buildOut.Bytes(), 0644); err != nil {
		return common.GetError("BuildRun", err)
	}

	return c.run(buildOut)
}

// accepts the output buffer for the build process in case it needs to be written to a file
func (c *Code) run(buildOut bytes.Buffer) (err error) {
	runContext, cancel := context.WithTimeout(context.Background(), time.Second*runtimeLimit)
	defer cancel()
	runCMD := exec.CommandContext(runContext, c.runCMD, c.runARGs...)
	var out bytes.Buffer
	runCMD.Stdout = &out //store output in out
	runCMD.Stderr = &out
	doneChan := make(chan bool)
	errChan := make(chan bool)
	go func() {
		if err = runCMD.Run(); err != nil {
			errChan <- true
		} else {
			doneChan <- true
		}
	}()

	select {
	case <-doneChan:
		if err = ioutil.WriteFile(c.OutputFile, out.Bytes(), 0644); err != nil {
			err = common.GetError("BuildRun", err)
		}
	case <-runContext.Done():
		// write the timeout error the the err file
		ioutil.WriteFile(c.CompilerErrFile, []byte("TIMEOUT: Process took too long to complete"), 0644)
		err = fmt.Errorf("BuildRun/TIMEOUT: Process took too long to complete")
	case <-errChan:
		ioutil.WriteFile(c.CompilerErrFile, buildOut.Bytes(), 0644)
	}
	return
}
