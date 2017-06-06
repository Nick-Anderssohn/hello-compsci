// Copyright (C) 2017  Nicholas Anderssohn
package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("Serving homepage on port 8080")
	http.Handle("/", http.FileServer(http.Dir("./build/home/web")))
	http.Handle("/about/", http.StripPrefix("/about/", http.FileServer(http.Dir("./build/about/web"))))
	http.ListenAndServe(":8080", nil)
}
