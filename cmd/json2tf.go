package cmd

import (
	"github.com/agaurav/sumo-util/libs"
	"github.com/spf13/cobra"
	"os"
)

func init() {
	rootCmd.AddCommand(json2tfCmd)
	json2tfCmd.Flags().String(FlagOutputShort, "", "output file")
}

const FlagOutputShort = "o"

var json2tfCmd = &cobra.Command{
	Use:   "json2tf",
	Short: "convert exported json from sumo ui to terraform",
	Long:  `convert exported json from sumo ui to terraform`,
	Args:  cobra.MinimumNArgs(1),
	Run: func(cmd *cobra.Command, args []string) {
		cmd.Version = Version

		out, err := cmd.Flags().GetString(FlagOutputShort)
		if err != nil {
			panic(err)
		}

		if out == "" {
			out, err = os.Getwd()
		}

		if err != nil {
			panic(err)
		}

		for _, arg := range args {
			err := libs.ConvertToTF(arg, out)

			if err != nil {
				panic(err)
			}
		}
	},
}
