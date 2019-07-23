package main

import (
	"gopher/pkg/server"
)

func main() {
	s := server.NewServer("127.0.0.1", 8088)
	s.Connect()
}
