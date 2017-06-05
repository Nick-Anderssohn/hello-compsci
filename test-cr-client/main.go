// Copyright (C) 2017  Nicholas Anderssohn

package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
)

const targetURL = "http://localhost:8080/test"

func main() {
	runTest("HelloWorld.java")
	runTest("BadWorld.java")
	runTest("test.c")
	runTest("bad_test.c")
	runTest("test.cpp")
	runTest("bad_test.cpp")
	runTest("test.go")
	runTest("bad.go")
	runTest("test.py")
	runTest("bad_test.py")
	runTest("loop.go")
}

func runTest(fName string) {
	fileReader, err := os.Open("testfiles/" + fName)
	if err != nil {
		log.Fatal(err.Error())
	}
	defer fileReader.Close()

	var client http.Client

	req, err := http.NewRequest("POST", targetURL, fileReader)
	if err != nil {
		log.Fatal(err.Error())
	}

	req.Header.Add("Filename", fName)

	resp, err := client.Do(req)
	if err != nil {
		log.Fatal(err.Error())
	}
	defer resp.Body.Close()
	body, _ := ioutil.ReadAll(resp.Body)

	fmt.Println(string(body))
}
