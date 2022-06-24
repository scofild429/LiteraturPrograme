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
        var dest []int64 = []int64{0}
        var send []int64 = []int64{10 * int64(newComm.Rank())}
        newComm.AllreduceInt64s(dest, send, mpi.OpSum, 0)
        if newComm.Rank() == 0 {
                fmt.Println(dest)
        }
        mpi.Stop()
}
