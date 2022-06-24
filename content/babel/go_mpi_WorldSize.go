package main


import (
        "fmt"
        mpi "github.com/sbromberger/gompi"
)
func main() {
        mpi.Start(true)
        size := mpi.WorldSize()
        fmt.Println("rank is", size)
        mpi.Stop()
}
