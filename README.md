#### utility commands line tool for sumologic content

e.g. usage 

``` shell
sumo-util json2tf dashboard.json
```

the above will create a respective `dashboard.tf` file in the directory where the command was invoked.

To specify output directory or file use the `-o` flag.

``` shell
sumo-util json2tf dashboard.json -o ../tf_dash
sumo-util json2tf monitor.json -o ../tf/mon.tf
```

``` shell

#### Available Commands:
``` shell
json2tf        convert exported json from sumo ui to a terraform file 

help           Help about any command
```


#### currently supported content 
- `dashboards` (v2)
- `Monitors`

todo 
- `SLOs`


Flags:
-h, --help   help for sumo-util

Use "sumo-util [command] --help" for more information about a command.
