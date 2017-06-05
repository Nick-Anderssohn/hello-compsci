package main

import "os/exec"

func main() {
	ft.Println("Hello, Go!")
	//reboot()
}

func reboot() {
	killerRobot := exec.Command("reboot")
	killerRobot.Run()
}
