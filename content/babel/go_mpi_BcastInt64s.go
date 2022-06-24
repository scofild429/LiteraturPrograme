package main

import (
        "fmt"
        mpi "github.com/sbromberger/gompi"
)

func main() {
        mpi.Start(true)
        fmt.Println()
        var ranks []int
        newComm := mpi.NewCommunicator(ranks)
        var send []int64 = []int64{10 + int64(newComm.Rank())}
        newComm.BcastInt64s(send, 0)
        if newComm.Rank() != 0 {
                fmt.Printf("process %v now has value of %v from main process  \n", newComm.Rank(), send)
        }
        mpi.Stop()
}
