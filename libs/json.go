package libs

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/buger/jsonparser"
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

	outFileName := filepath.Join(out, giveTFFileName(path))

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

	err = dashboardTemplate.Execute(buff, dashObj)
	if err != nil {
		return err
	}
	//if _, err := os.Stat(outFile); os.IsExist(err) {
	//	panic(fmt.Sprintf("the file to be created already '%s' already exists", outFile))
	//}

	return ioutil.WriteFile(outFile, buff.Bytes(), 0644)
}

func convertMonitorsJSONToTF(jsonBytes []byte, outFile string) error {
	return nil
}

func giveTFFileName(path string) string {
	_, filename := filepath.Split(path)
	return filename[:len(filename)-5] + ".tf"
}
