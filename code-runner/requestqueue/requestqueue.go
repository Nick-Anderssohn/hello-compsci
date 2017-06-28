// Copyright (C) 2017  Nicholas Anderssohn
package requestqueue

import "net/http"

// ReqIO holds the http.ResponseWriter and *http.Request associated with a Request
type ReqIO struct {
	Writer  http.ResponseWriter
	Request *http.Request
}

// RequestQueue holds requests and processes them one after another rather than at the same time
type RequestQueue struct {
	requests    []*ReqIO
	readyChan   chan bool
	processFunc func(writer http.ResponseWriter, req *http.Request)
}

func NewRequestQueue(readyChan chan bool, processFunc func(writer http.ResponseWriter, req *http.Request)) *RequestQueue {
	return &RequestQueue{
		make([]*ReqIO, 0),
		readyChan,
		processFunc,
	}
}

// Processes only the first Request in the queue
func (rq *RequestQueue) ProcessRequest(codeReq *ReqIO) {
	rq.requests = append(rq.requests, codeReq)
	<-rq.readyChan
	rq.runNextReq()
}

func (rq *RequestQueue) runNextReq() {
	rq.processFunc(rq.requests[0].Writer, rq.requests[0].Request)
	rq.requests = rq.requests[1:]
}
