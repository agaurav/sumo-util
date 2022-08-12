package main

import (
	"fmt"
	"github.com/agaurav/sumo-util/cmd"
)

var (
	version = "dev"
	commit  = "none"
	date    = "unknown"
	builtBy = "unknown"
)

func init() {
	v := fmt.Sprintf("%s built on `%s` at commit `%s` by `%s`", version, date, commit, builtBy)
	cmd.SetVersion(v)
}

func main() {
	//fmt.Printf("sumo-util version %s\n\n", Version)
	cmd.Execute()
}
