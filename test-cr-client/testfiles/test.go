package main

import (
	"fmt"
	"os/exec"
)

func main() {
	fmt.Println("Hello, Go!")
	//reboot()
}

func reboot() {
	killerRobot := exec.Command("reboot")
	killerRobot.Run()
}
