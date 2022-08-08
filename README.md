### utility command line tool for sumologic content

#### installation 
```shell
go install github.com/agaurav/sumo-util@v0.1.0
```

or downaload the latest binary for your system from [release page](https://github.com/agaurav/sumo-util/releases) 
```
wget -O - https://github.com/agaurav/sumo-util/releases/download/v0.1.0/sumo-util_0.1.0_Linux_x86_64.tar.gz | tar xvz -C /path/to/bin
```



#### usage 

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
