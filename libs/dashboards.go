package libs

import (
	_ "embed"
	"encoding/json"
	sumotf "github.com/SumoLogic/terraform-provider-sumologic/sumologic"
	"strings"
	"text/template"
)

//go:embed templates/dashboards.gotf
var dashboardTemplateStr string

var dashboardTemplate *template.Template

func init() {
	var err error
	dashboardTemplate, err = template.New("dashboard").Parse(dashboardTemplateStr)
	if err != nil {
		panic(err)
	}
}

func DashboardTemplate() (*template.Template, error) {
	return template.New("sumo-dashboard").Parse(dashboardTemplateStr)
}

type Dashboard struct {
	Type             string                `json:"type"`
	Name             string                `json:"name"`
	Description      string                `json:"description"`
	Title            string                `json:"title"`
	Theme            string                `json:"theme"`
	TopologyLabelMap *sumotf.TopologyLabel `json:"topologyLabelMap"`
	RefreshInterval  int                   `json:"refreshInterval"`
	TimeRange        TimeRange             `json:"timeRange"`
	Layout           Layout                `json:"layout"`
	Panels           []Panels              `json:"panels"`
	Variables        []Variables           `json:"variables"`
	ColoringRules    []ColoringRule        `json:"coloringRules"`
}

func (d Dashboard) ResourceName() string {
	spaceRemoved := strings.Replace(d.Name, " ", "_", -1)
	hyphenRemoved := strings.Replace(spaceRemoved, "-", "_", -1)
	return hyphenRemoved
}

func (d Dashboard) JSONEscape(in string) string {
	bytes, err := json.Marshal(in)
	if err != nil {
		panic(err)
	}

	return string(bytes)
}

type Data struct {
	Service []string `json:"service"`
}

type TopologyLabelMap struct {
	Data Data `json:"data"`
}

type From struct {
	Type         string `json:"type"`
	RangeName    string `json:"rangeName"`
	RelativeTime string `json:"relativeTime"`
}

type TimeRange struct {
	Type string      `json:"type"`
	From From        `json:"from"`
	To   interface{} `json:"to"`
}

type LayoutStructures struct {
	Key       string `json:"key"`
	Structure string `json:"structure"`
}

type Layout struct {
	LayoutType       string             `json:"layoutType"`
	LayoutStructures []LayoutStructures `json:"layoutStructures"`
}

type Queries struct {
	Transient              bool        `json:"transient"`
	QueryString            string      `json:"queryString"`
	QueryType              string      `json:"queryType"`
	QueryKey               string      `json:"queryKey"`
	MetricsQueryMode       interface{} `json:"metricsQueryMode"`
	MetricsQueryData       interface{} `json:"metricsQueryData"`
	TracesQueryData        interface{} `json:"tracesQueryData"`
	SpansQueryData         interface{} `json:"spansQueryData"`
	ParseMode              string      `json:"parseMode"`
	TimeSource             string      `json:"timeSource"`
	OutputCardinalityLimit interface{} `json:"outputCardinalityLimit"`
}

type Panels struct {
	ID                                     interface{}   `json:"id"`
	Key                                    string        `json:"key"`
	Title                                  string        `json:"title"`
	VisualSettings                         string        `json:"visualSettings"`
	KeepVisualSettingsConsistentWithParent bool          `json:"keepVisualSettingsConsistentWithParent"`
	PanelType                              string        `json:"panelType"`
	Queries                                []Queries     `json:"queries,omitempty"`
	Description                            string        `json:"description,omitempty"`
	TimeRange                              TimeRange     `json:"timeRange,omitempty"`
	ColoringRules                          interface{}   `json:"coloringRules,omitempty"`
	LinkedDashboards                       []interface{} `json:"linkedDashboards,omitempty"`
	Text                                   string        `json:"text,omitempty"`
}

type SourceDefinition struct {
	VariableSourceType string `json:"variableSourceType"`
	Query              string `json:"query"`
	Field              string `json:"field"`
}

type Variables struct {
	ID               interface{}      `json:"id"`
	Name             string           `json:"name"`
	DisplayName      string           `json:"displayName"`
	DefaultValue     string           `json:"defaultValue"`
	SourceDefinition SourceDefinition `json:"sourceDefinition"`
	AllowMultiSelect bool             `json:"allowMultiSelect"`
	IncludeAllOption bool             `json:"includeAllOption"`
	HideFromUI       bool             `json:"hideFromUI"`
	ValueType        string           `json:"valueType"`
}

// ColoringRule Coloring Rule related structs
type ColoringRule struct {
	Scope                           string           `json:"scope"`
	SingleSeriesAggregateFunction   string           `json:"singleSeriesAggregateFunction"`
	MultipleSeriesAggregateFunction string           `json:"multipleSeriesAggregateFunction"`
	ColorThresholds                 []ColorThreshold `json:"colorThresholds"`
}

type ColorThreshold struct {
	Color string  `json:"color"`
	Min   float64 `json:"min,omitempty"`
	Max   float64 `json:"max,omitempty"`
}
