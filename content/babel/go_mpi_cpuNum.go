package main

import (
	"fmt"
	"runtime"
)

func main() {
	cpuNum := runtime.NumCPU()
	fmt.Println("cpu number is :", cpuNum)
	runtime.GOMAXPROCS(cpuNum)
}
