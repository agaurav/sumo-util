package libs

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/buger/jsonparser"
	"github.com/kr/pretty"
	"io/ioutil"
	"path/filepath"
)

const (
	ContentTypeDashboard = "DashboardV2SyncDefinition"
	ContentTypeMonitors  = "MonitorsLibraryMonitorExport"
)

func ConvertToTF(path string, out string) error {

	jsonBytes, err := ioutil.ReadFile(path)

	if err != nil {
		return err
	}

	contentType, err := jsonparser.GetString(jsonBytes, "type")

	if err != nil {
		return err
	}

	outFileName := out
	if out[len(out)-3:] != ".tf" {
		outFileName = filepath.Join(out, giveTFFileName(path))
	}

	switch contentType {
	case ContentTypeDashboard:
		return convertDashboardJSONToTF(jsonBytes, outFileName)
	case ContentTypeMonitors:
		return convertMonitorsJSONToTF(jsonBytes, outFileName)
	default:
		return fmt.Errorf("unknown content type: %s", contentType)
	}

	return nil
}

func convertDashboardJSONToTF(jsonBytes []byte, outFile string) error {
	dashObj := Dashboard{}

	err := json.Unmarshal(jsonBytes, &dashObj)

	if err != nil {
		return err
	}
	buff := &bytes.Buffer{}

	err = monitorsTemplate.Execute(buff, dashObj)
	if err != nil {
		return err
	}
	//if _, err := os.Stat(outFile); os.IsExist(err) {
	//	panic(fmt.Sprintf("the file to be created already '%s' already exists", outFile))
	//}

	return ioutil.WriteFile(outFile, buff.Bytes(), 0644)
}

func convertMonitorsJSONToTF(jsonBytes []byte, outFile string) error {
	monObj := Monitors{}
	err := json.Unmarshal(jsonBytes, &monObj)

	pretty.Println(monObj, monObj.TriggersClubbed())

	if err != nil {
		return err
	}

	buff := &bytes.Buffer{}
	err = monitorsTemplate.Execute(buff, monObj)

	if err != nil {
		return err
	}

	return ioutil.WriteFile(outFile, buff.Bytes(), 0644)
}

func giveTFFileName(path string) string {
	_, filename := filepath.Split(path)
	return filename[:len(filename)-5] + ".tf"
}
