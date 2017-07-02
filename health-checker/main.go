// Copyright (C) 2017  Nicholas Anderssohn
package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"net/http"
	"os/exec"
	"time"
)

const targetURL = "http://0.0.0.0:8079/"

var testCode = `#include <stdio.h>
int main() {
printf("test");
}`

type codeReader struct{}

func (c codeReader) Read(p []byte) (int, error) {
	for i, char := range testCode {
		p[i] = byte(char)
	}
	return len(testCode), nil
}

func main() {
	fmt.Println("starting health checker")
	for range time.Tick(time.Second) {
		// every second send a health check to code-runner
		var client http.Client
		req, _ := http.NewRequest("POST", targetURL, bytes.NewBufferString(testCode))
		req.Header.Add("Filename", "test.c")
		checkHealth(client, req)
	}
}

func checkHealth(client http.Client, req *http.Request) {
	resp, err := client.Do(req)
	// fmt.Println(err.Error())
	if err != nil {
		fmt.Println("Health check failed! Creating new code-runner")
		createNewCodeRunner()
	} else {
		defer resp.Body.Close() // only close if there was not an error
		if body, _ := ioutil.ReadAll(resp.Body); string(body) != "test" {
			fmt.Println("Health check failed! Creating new code-runner")
			createNewCodeRunner()
		}
	}
}

func createNewCodeRunner() {
	restartCMD := exec.Command("./restart_coderunner.sh")
	restartCMD.Run()
	time.Sleep(250 * time.Millisecond)
}
