pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import config

Scope {
	id: root

	readonly property bool _enabled: Config.services.uptimeEnabled

	property string uptimeStr: ""

	Process {
		id: uptimeProc
		command: ["sh", "-c", "uptime -p | sed 's/^up //; s/,//g; s/ minute/m/; s/ hour/h/; s/ day/d/; s/s//g'"]
		running: root._enabled

		stdout: StdioCollector {
			onStreamFinished: root.uptimeStr = this.text
		}
	}

	Timer {
		interval: Config.services.uptimeTimer
		running: root._enabled
		repeat: root._enabled
		onTriggered: uptimeProc.running = true
	}
}
