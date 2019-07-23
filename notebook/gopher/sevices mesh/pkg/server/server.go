package server

import (
	"fmt"
)

//Server 服务类
type Server struct {
	address string
	port    int
}

//NewServer 初始化服务的参数
func NewServer(address string, port int) *Server {
	return &Server{
		address: address,
		port:    port,
	}
}

//Connect 服务
func (s *Server) Connect() {
	host := fmt.Sprintf("http://%s:%d", s.address, s.port)
	fmt.Println(host)
}
