package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {

	files, err := ioutil.ReadDir("./appStuff")
	if err != nil {
		log.Fatal(err)
	}

	for _, f := range files {
		fmt.Println(f.Name())
	}

	fs := http.FileServer(http.Dir("./appStuff/data"))
	http.Handle("/data/", http.StripPrefix("/data/", fs))

	http.HandleFunc("/saxgif", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("attempting to server something on /saxgif")
		http.ServeFile(w, r, "./appStuff/data/epic-sax-guy-saxophone.gif")
	})

	http.HandleFunc("/image", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("attempting to server something on /image")
		http.ServeFile(w, r, "./appStuff/image.html")
	})
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Println("attempting to server something on /")
		http.ServeFile(w, r, "./appStuff/image.html")
	})

	fmt.Println("Server started at port 8076")
	http.ListenAndServe(":8076", nil)
}
