// Copyright (C) 2017  Nicholas Anderssohn

package codedirector

import (
	"fmt"
	"net/http"
	"net/http/httputil"
	"net/url"
)

var runners []*httputil.ReverseProxy

var codeRunnerIndex = 0

func init() {

	url1, _ := url.Parse("http://code-runner1:8079")
	url2, _ := url.Parse("http://code-runner2:8079")
	url3, _ := url.Parse("http://code-runner3:8079")
	url4, _ := url.Parse("http://code-runner4:8079")
	url5, _ := url.Parse("http://code-runner5:8079")
	url6, _ := url.Parse("http://code-runner6:8079")
	url7, _ := url.Parse("http://code-runner7:8079")
	url8, _ := url.Parse("http://code-runner8:8079")
	url9, _ := url.Parse("http://code-runner9:8079")
	url10, _ := url.Parse("http://code-runner10:8079")

	runners = []*httputil.ReverseProxy{
		httputil.NewSingleHostReverseProxy(url1),
		httputil.NewSingleHostReverseProxy(url2),
		httputil.NewSingleHostReverseProxy(url3),
		httputil.NewSingleHostReverseProxy(url4),
		httputil.NewSingleHostReverseProxy(url5),
		httputil.NewSingleHostReverseProxy(url6),
		httputil.NewSingleHostReverseProxy(url7),
		httputil.NewSingleHostReverseProxy(url8),
		httputil.NewSingleHostReverseProxy(url9),
		httputil.NewSingleHostReverseProxy(url10),
	}

	http.HandleFunc("/", handleReq)
}

func handleReq(w http.ResponseWriter, req *http.Request) {
	defer req.Body.Close()
	formResponseHeader(w, req)

	// browsers will first send a request of type OPTIONS to verify that they are okay to send
	// whatever request they are trying to send
	if req.Method == "OPTIONS" {
		handleOptions(w, req)
	} else if req.Method == "POST" {
		sendToNextCodeRunner(w, req)
	}
}

func handleOptions(w http.ResponseWriter, req *http.Request) {
	// TODO: potentially should check if req will be malformed
	w.WriteHeader(http.StatusOK)
}

func formResponseHeader(w http.ResponseWriter, req *http.Request) {
	w.Header().Add("Access-Control-Allow-Origin", req.Header.Get("Origin"))
	w.Header().Add("Access-Control-Allow-Methods", "POST")
	w.Header().Add("Access-Control-Allow-Headers", "Filename")
}

func sendToNextCodeRunner(w http.ResponseWriter, req *http.Request) {
	if codeRunnerIndex >= len(runners) {
		codeRunnerIndex = 0
	}
	runners[codeRunnerIndex].ServeHTTP(w, req)
	codeRunnerIndex++
}

func Run() {
	if err := http.ListenAndServe(":8050", nil); err != nil {
		fmt.Println(err.Error())
	}
}
