package main

import (
	"fmt"
)

const (
	Major = 0
	Minor = 0
	Patch = 3
)

func Version() string {
	return fmt.Sprintf("%d.%d.%d", Major, Minor, Patch)
}
