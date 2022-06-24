package main


import (
        "fmt"
        mpi "github.com/sbromberger/gompi"
)
func main() {
        mpi.Start(true)
        rank := mpi.WorldRank()
        fmt.Println("rank is", rank)
        mpi.Stop()
}
