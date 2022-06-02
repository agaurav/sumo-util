package main

import (
	"fmt"
	"github.com/agaurav/sumo-util/cmd"
)

func main() {

	fmt.Println("a")
	cmd.Execute()
	//t, err := libs.DashboardTemplate()
	//
	//if err != nil {
	//	panic(err)
	//}
	//
	//dashJSONBytes, err := ioutil.ReadFile("samples/dash.json")
	//
	//dashObj := libs.Dashboard{}
	//
	//json.Unmarshal(dashJSONBytes, &dashObj)
	//
	//pretty.Println(dashObj)
	//
	//err = t.Execute(os.Stdout, dashObj)
	//
	//if err != nil {
	//	panic(err)
	//}
}
