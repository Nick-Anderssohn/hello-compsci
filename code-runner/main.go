// Copyright (C) 2017  Nicholas Anderssohn

package main

import (
	"fmt"
	"hello-class/code-runner/codeserver"
	"log"
	"os"
	"strconv"
)

func main() {
	port := 8080
	if len(os.Args) > 1 {
		if tempPort, err := strconv.Atoi(os.Args[1]); err == nil {
			port = tempPort
		}
	}
	fmt.Println("creating server...")
	codeServer := codeserver.NewServer(log.New(os.Stdout, "", 0), port)
	fmt.Println("Running server...")
	codeServer.Run()
}
