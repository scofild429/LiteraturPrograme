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
                str1 := "str11"
                newComm.SendString("nihao", 1, 11)
                newComm.SendString(str1, 1, 10)
        }
        // better with differ tags, but with the same tags works here also
        if newComm.Rank() == 1 {
                nihao, _ := newComm.RecvString(0, 11)
                str1, _ := newComm.RecvString(0, 10)
                fmt.Println(nihao)
                fmt.Println(str1)
        }
        mpi.Stop()
}
