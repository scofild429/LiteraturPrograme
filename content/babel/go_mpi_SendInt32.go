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
                var data int32 = 66
                newComm.SendInt32(data, 1, 10)
        }
        if newComm.Rank() == 1 {
                data, _ := newComm.RecvInt32(0, 10)
                fmt.Println(data)
        }
        mpi.Stop()
}
