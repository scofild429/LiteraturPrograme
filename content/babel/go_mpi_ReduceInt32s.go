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
        var dest []int32 = []int32{0}
        var send []int32 = []int32{9}
        newComm.ReduceInt32s(dest, send, mpi.OpSum, 0)
        if newComm.Rank() == 0 {
                fmt.Println(dest)
        }
        mpi.Stop()
}
