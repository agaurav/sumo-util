package libs

type Monitors struct {
	Name                    string            `json:"name"`
	Description             string            `json:"description"`
	Type                    string            `json:"type"`
	MonitorType             string            `json:"monitorType"`
	EvaluationDelay         string            `json:"evaluationDelay"`
	AlertName               interface{}       `json:"alertName"`
	RunAs                   interface{}       `json:"runAs"`
	NotificationGroupFields []interface{}     `json:"notificationGroupFields"`
	Queries                 []QueriesMonitors `json:"queries"`
	Triggers                []Triggers        `json:"triggers"`
	Notifications           []interface{}     `json:"notifications"`
	IsDisabled              bool              `json:"isDisabled"`
	GroupNotifications      bool              `json:"groupNotifications"`
	Playbook                string            `json:"playbook"`
	SloID                   interface{}       `json:"sloId"`
}
type QueriesMonitors struct {
	RowID string `json:"rowId"`
	Query string `json:"query"`
}
type Triggers struct {
	DetectionMethod string      `json:"detectionMethod"`
	TriggerType     string      `json:"triggerType"`
	TimeRange       string      `json:"timeRange"`
	Threshold       int         `json:"threshold"`
	ThresholdType   string      `json:"thresholdType"`
	Field           interface{} `json:"field"`
	OccurrenceType  string      `json:"occurrenceType"`
	TriggerSource   string      `json:"triggerSource"`
}
