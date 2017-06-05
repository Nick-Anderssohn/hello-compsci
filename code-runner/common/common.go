// Copyright (C) 2017  Nicholas Anderssohn

package common

import "fmt"

//GetError return properly formatted error for stack trace
func GetError(funcName string, err error) error {
	return fmt.Errorf(funcName+"/%v", err.Error())
}
