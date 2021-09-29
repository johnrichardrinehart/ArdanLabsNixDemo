package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"net"
)

func handleRoot(w http.ResponseWriter, req *http.Request) {
	w.WriteHeader(http.StatusOK)
}

func getListener() (net.Listener, error) {
	listener, err := net.Listen("tcp", "127.0.0.1:0") // random available port
	if err != nil {
		return nil, fmt.Errorf("failed to obtain open port: %s", err)
	}

	return listener, nil
}

func startHTTPServer(ch chan error, l net.Listener) {
	addr := l.Addr().String()

	srv := http.Server{
		Handler: http.HandlerFunc(handleRoot),
	}


	go func() {
		log.Printf("starting an HTTP server on %s", addr)
		if err := srv.Serve(l); err != nil {
			log.Printf("HTTP server failed at runtime: %s", err)
			ch <- err
		}
	}()

}

func main() {
	l, err := getListener()
	if err != nil {
		log.Fatalf("failed to obtain listener: %s", err)
	}

	fail := make(chan error) // signal runtime failures to main
	startHTTPServer(fail, l) // non-blocking

	sig := make(chan os.Signal, 1)
	signal.Notify(sig, os.Interrupt) // handle SIGINT

	done := make(chan bool, 1) // initiate application shutdown

	go func() {
		for range sig {
			close(done)
		}
	}()

	select {
	case <-done:
		log.Println("Best HTTP server in the world is exiting (clean shutdown)...")

	case err := <-fail:
		log.Printf("Best HTTP server in the world is exiting (runtime exception)...: %s", err)
	}
}

