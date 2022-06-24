package main


import (
        "fmt"
        mpi "github.com/sbromberger/gompi"
)
func main() {
        ison := mpi.IsOn()
        if ison {
                fmt.Println("ison is on")
        } else {
                fmt.Println("ison is  not on")
        }
        mpi.Start(true)
        ison = mpi.IsOn()
        if ison {
                fmt.Println("ison is on")
        } else {
                fmt.Println("ison is  not on ")
        }
        mpi.Stop()
}
