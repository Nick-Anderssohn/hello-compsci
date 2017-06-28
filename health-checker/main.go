// Copyright (C) 2017  Nicholas Anderssohn
package main

import (
	"fmt"
	"net/http"
	"os/exec"
	"time"
)

const targetURL = "http://0.0.0.0:8079/healthcheck"

func main() {
	fmt.Println("starting health checker")
	for range time.Tick(time.Second) {
		// every second send a health check to code-runner
		var client http.Client
		req, _ := http.NewRequest("GET", targetURL, nil)
		resp, err := client.Do(req)
		if err != nil {
			fmt.Println("Health check failed! Creating new code-runner")
			createNewCodeRunner()
		} else {
			resp.Body.Close()
		}
	}
}

func createNewCodeRunner() {
	restartCMD := exec.Command("./restart_coderunner.sh")
	restartCMD.Run()
	time.Sleep(250 * time.Millisecond)
}
