package main


import (
        "fmt"

        mpi "github.com/sbromberger/gompi"
)

type Vector []float64

func main() {
        mpi.Start(true)
        fmt.Println()
        var ranks []int 
        //var ranks []int = []int{0, 1, 2, 3, 4, 5}
        newComm := mpi.NewCommunicator(ranks)
        if newComm.Rank() == 0 {
                var data []uint32 = []uint32{1, 2}
                newComm.SendUInt32s(data, 1, 10)
        }
        if newComm.Rank() == 1 {
                data, _ := newComm.RecvInt32s(0, 10)
                fmt.Println(data)
        }
        mpi.Stop()
}
