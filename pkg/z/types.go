package z

import (
	"github.com/gojekfarm/ziggurat-go/pkg/zb"
)

type HandlerFunc func(messageEvent zb.MessageEvent, app App) ProcessStatus

func (h HandlerFunc) HandleMessage(event zb.MessageEvent, app App) ProcessStatus {
	return h(event, app)
}

type StartFunction func(a App)
type StopFunction func()

const ProcessingSuccess ProcessStatus = 0
const RetryMessage ProcessStatus = 1
const SkipMessage ProcessStatus = 2

type ProcessStatus int
