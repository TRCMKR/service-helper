package main

import (
	"github.com/iancoleman/strcase"
	"google.golang.org/protobuf/compiler/protogen"
)

func generateFile(gen *protogen.Plugin, file *protogen.File) {
	filename := file.GeneratedFilenamePrefix + ".pb.go"
	g := gen.NewGeneratedFile(filename, file.GoImportPath)

	g.P("package ", file.GoPackageName)
	g.P()

	g.P("import _ \"embed\"")

	g.P("// go:embed " + file.GeneratedFilenamePrefix + ".swagger.json")

	varName := strcase.ToLowerCamel(file.GeneratedFilenamePrefix + "SwaggerJSON")
	g.P("var " + varName + "[] byte")
}
