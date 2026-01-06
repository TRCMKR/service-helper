package main

import (
	"flag"
	"fmt"
	"os"
	"path/filepath"

	"google.golang.org/protobuf/compiler/protogen"
)

func main() {
	if len(os.Args) == 2 && os.Args[1] == "--version" {
		fmt.Fprintf(os.Stdout, "%v %v\n", filepath.Base(os.Args[0]), Version())
		os.Exit(0)
	}

	protogen.Options{
		ParamFunc: flag.Set,
	}.Run(func(plugin *protogen.Plugin) error {
		for _, file := range plugin.Files {
			if file.Generate {
				generateFile(plugin, file)
			}
		}

		return nil
	})
}
