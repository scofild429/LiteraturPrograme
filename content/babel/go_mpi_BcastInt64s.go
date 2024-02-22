package main

import (
        "fmt"
        mpi "github.com/sbromberger/gompi"
)

func main() {
        mpi.Start(true)
        var ranks []int
        newComm := mpi.NewCommunicator(ranks)
        var send []int64 = []int64{10 + int64(newComm.Rank())}
        fmt.Printf("process %v now has original value of %v from main process  \n", newComm.Rank(), send)
        newComm.BcastInt64s(send, 0)
        if newComm.Rank() != 0 {
           fmt.Printf("process %v now has bordcasted value of %v from main process  \n", newComm.Rank(), send)
        }
        mpi.Stop()
}
