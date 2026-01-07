package main

import (
	"fmt"
)

const (
	Major = 0
	Minor = 1
	Patch = 1
)

func Version() string {
	return fmt.Sprintf("%d.%d.%d", Major, Minor, Patch)
}
