// Copyright (C) 2017  Nicholas Anderssohn

package runner

import (
	"bytes"
	"fmt"
	"hello-class/code-runner/common"
	"io/ioutil"
	"os/exec"
	"path/filepath"
	"strings"
	"time"
)

const runtimeLimit = 3 // seconds
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

//Run runs runFile and stores a path to an output file
func (c *Code) Run() (err error) {
	//<-ReadyToBuildChan // block until ready to build

	//build
	buildCMD := exec.Command(c.buildCMD, c.buildARGs...)
	var buildOut bytes.Buffer
	buildCMD.Stderr = &buildOut
	buildCMD.Run()

	//write output to file
	if err = ioutil.WriteFile(c.CompilerErrFile, buildOut.Bytes(), 0644); err != nil {
		return common.GetError("Run", err)
	}
	//execute the runFile
	runCMD := exec.Command(c.runCMD, c.runARGs...)
	var out bytes.Buffer
	runCMD.Stdout = &out //store output in out
	runCMD.Stderr = &out

	done := make(chan error)

	if err = runCMD.Start(); err != nil {
		ioutil.WriteFile(c.CompilerErrFile, buildOut.Bytes(), 0644)
		return common.GetError("Run", err)
	}

	go waitForCMD(runCMD, done) // keep track if the process finishes or loops for too long

	return c.handleFinishRun(runCMD, &out, done)
}

func waitForCMD(cmd *exec.Cmd, ch chan error) {
	ch <- cmd.Wait()
}

func (c *Code) handleFinishRun(runCMD *exec.Cmd, output *bytes.Buffer, done chan error) (err error) {
	select {
	// after 3 seconds, kill the process
	case <-time.After(time.Second * runtimeLimit):
		runCMD.Process.Kill()

		// write the timeout error the the err file
		ioutil.WriteFile(c.CompilerErrFile, []byte("TIMEOUT: Process took too long to complete"), 0644)

		err = fmt.Errorf("Run/TIMEOUT: Process took too long to complete")
	case <-done:
		// the code was run successfully, write the output to the output file
		if err = ioutil.WriteFile(c.OutputFile, output.Bytes(), 0644); err != nil {
			err = common.GetError("Run", err)
		}
	}
	ReadyToBuildChan <- true
	return
}
