package main

import (
	"flag"

	"google.golang.org/protobuf/compiler/protogen"
)

func main() {
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
