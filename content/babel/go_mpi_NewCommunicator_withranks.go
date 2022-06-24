package main


import (
        "fmt"
        mpi "github.com/sbromberger/gompi"
)
func main() {
        mpi.Start(true)
        var ranks []int = []int{0,1,2,3}
        newComm := mpi.NewCommunicator(ranks)
        fmt.Println("newComm.Size() is :", newComm.Size())
        fmt.Println("newComm.Rank() is :", newComm.Rank())
        mpi.Stop()
}
