package libs

import "strings"

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
	Triggers                []Trigger         `json:"triggers"`
	Notifications           []Notifications   `json:"notifications"`
	IsDisabled              bool              `json:"isDisabled"`
	GroupNotifications      bool              `json:"groupNotifications"`
	Playbook                string            `json:"playbook"`
	SloID                   interface{}       `json:"sloId"`
}

func (m Monitors) ResourceName() string {
	spaceRemoved := strings.Replace(m.Name, " ", "_", -1)
	hyphenRemoved := strings.Replace(spaceRemoved, "-", "_", -1)
	return hyphenRemoved
}

func (m Monitors) TriggersClubbed() map[string]*CombinedTrigger {

	triggersMap := make(map[string]*CombinedTrigger)

	for i, _ := range m.Triggers {
		t := m.Triggers[i]

		if triggersMap[t.DetectionMethod] == nil {
			triggersMap[t.DetectionMethod] = &CombinedTrigger{}
		}
		comboTrigger := triggersMap[t.DetectionMethod]

		switch t.TriggerType {
		case "Critical":
			comboTrigger.Critical = &t
		case "ResolvedCritical":
			comboTrigger.ResolvedCritical = &t
		case "Warning":
			comboTrigger.Warning = &t
		case "ResolvedWarning":
			comboTrigger.ResolvedWarning = &t
		}
		comboTrigger.Trigger = t
	}

	return triggersMap
}

type CombinedTrigger struct {
	Trigger
	Critical         *Trigger
	ResolvedCritical *Trigger
	Warning          *Trigger
	ResolvedWarning  *Trigger
}

type QueriesMonitors struct {
	RowID string `json:"rowId"`
	Query string `json:"query"`
}
type Trigger struct {
	TimeRange         string  `json:"timeRange"`
	TriggerType       string  `json:"triggerType"`
	Threshold         float64 `json:"threshold,omitempty"`
	ThresholdType     string  `json:"thresholdType,omitempty"`
	OccurrenceType    string  `json:"occurrenceType"`
	TriggerSource     string  `json:"triggerSource"`
	DetectionMethod   string  `json:"detectionMethod"`
	Field             string  `json:"field,omitempty"`
	Window            int     `json:"window,omitempty"`
	BaselineWindow    string  `json:"baselineWindow,omitempty"`
	Consecutive       int     `json:"consecutive,omitempty"`
	Direction         string  `json:"direction,omitempty"`
	SLIThreshold      float64 `json:"sliThreshold,omitempty"`
	BurnRateThreshold float64 `json:"burnRateThreshold,omitempty"`
}

type Notification struct {
	ActionType      string   `json:"actionType,omitempty"`
	ConnectionType  string   `json:"connectionType,omitempty"`
	Subject         string   `json:"subject"`
	Recipients      []string `json:"recipients"`
	MessageBody     string   `json:"messageBody"`
	TimeZone        string   `json:"timeZone"`
	ConnectionID    string   `json:"connectionId"`
	PayloadOverride string   `json:"payloadOverride,omitempty"`
}

type Notifications struct {
	Notification       Notification `json:"notification"`
	RunForTriggerTypes []string     `json:"runForTriggerTypes"`
}

func (m Monitors) GetNotifyEmails() []Notifications {
	var notifications []Notifications
	for _, n := range m.Notifications {
		if n.Notification.ConnectionType == "Email" {
			notifications = append(notifications, n)
		}
	}
	return notifications
}

func (m Monitors) GetNotifyConnections() []Notifications {
	var notifications []Notifications
	for _, n := range m.Notifications {
		if n.Notification.ConnectionType != "Email" {
			notifications = append(notifications, n)
		}
	}
	return notifications
}

type NotifyEmail struct {
	Recipients     []string
	Subject        string
	Body           string
	TimeZone       string
	RunForTriggers []string
}

type NotifyConnection struct {
	ID             string
	Type           string
	RunForTriggers []string
}
