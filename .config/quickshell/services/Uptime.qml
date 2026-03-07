pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Scope {
	id: root

	property string uptimeStr

	Process {
		id: uptimeProc
		command: ["sh", "-c", "uptime -p | sed 's/^up //; s/,//g; s/ minute/m/; s/ hour/h/; s/ day/d/; s/s//g'"]
		running: true

		stdout: StdioCollector {
			onStreamFinished: root.uptimeStr = this.text
		}
	}

	Timer {
		interval: 60000
		running: true
		repeat: true
		onTriggered: uptimeProc.running = true
	}
}
