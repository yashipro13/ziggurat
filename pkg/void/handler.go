package void

import (
	"github.com/gojekfarm/ziggurat/pkg/z"
	"github.com/gojekfarm/ziggurat/pkg/zb"
)

type VoidMessageHandler struct{}

func (v VoidMessageHandler) HandleMessage(event zb.MessageEvent, app z.App) z.ProcessStatus {
	return z.ProcessingSuccess
}
