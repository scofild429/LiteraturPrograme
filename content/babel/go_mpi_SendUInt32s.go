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
        if newComm.Rank() == 0 {
                var data []uint32 = []uint32{1, 2, 3}
                newComm.SendUInt32s(data, 1, 10)
        }
        if newComm.Rank() == 1 {
                data, _ := newComm.RecvInt32s(0, 10)
                fmt.Println(data)
        }
        mpi.Stop()
}
