package cmd

var Version = ""

func SetVersion(v string) {
	rootCmd.Version = v
}
