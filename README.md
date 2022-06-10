#### utility commands line tool for sumologic content

e.g. usage 

``` shell
sumo-util json2tf dashboard.json
```

the above will create a respective `dashboard.tf` file where the command was invoked.

#### Available Commands:
``` shell
json2tf        convert exported json from sumo ui to a terraform file 

help           Help about any command
```


#### currently supported content 
- `dashboards` (v2)

todo 
- `Monitors`
- `SLOs`


Flags:
-h, --help   help for sumo-util

Use "sumo-util [command] --help" for more information about a command.
