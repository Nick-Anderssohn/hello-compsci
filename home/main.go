package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("Serving homepage on port 8080")
	http.Handle("/", http.FileServer(http.Dir("./build/web")))
	http.ListenAndServe(":8080", nil)
}
