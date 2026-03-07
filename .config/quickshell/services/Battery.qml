import Quickshell
import Quickshell.Io
import QtQuick

Scope {
	id: root

	property string target

	readonly property string capPath: `/sys/class/power_supply/${target}/capacity`
	readonly property string statPath: `/sys/class/power_supply/${target}/status`
	readonly property string totalPath: `/sys/class/power_supply/${target}/energy_full`
	readonly property string curPath: `/sys/class/power_supply/${target}/energy_now`
	readonly property string drawPath: `/sys/class/power_supply/${target}/power_now`

	property string capacity
	property string status
	property string time

	Process {
		id: batProc
		command: ["sh", "-c", `cat ${root.capPath} && cat ${root.statPath} && cat ${root.totalPath} && cat ${root.curPath} && cat ${root.drawPath}`]
		running: true

		stdout: StdioCollector {
			onStreamFinished: {
				var raw = this.text.trim().split(/\s+/)

				if (raw.length >= 5) {
					root.capacity = raw[0]
					root.status = raw[1]

					const total = parseFloat(raw[2])
					const current = parseFloat(raw[3])
					const draw = parseFloat(raw[4])

					if (draw > 0) {
						let duration = 0
						if (root.status === "Charging") {
							duration = (total - current) / draw
						} else if (root.status === "Discharging") {
							duration = current / draw
						}

						if (duration > 0) {
							let h = Math.floor(duration)
							let m = Math.floot((duration - h) * 60)
							root.time = (h > 0) ? `${h}h ${m}m` : `${m}m`
						} else {
							root.time = ""
						}
					}
				} else {
					root.capacity = "??"
					root.status = "??"
					root.time = "??"
				}
			}
		}
	}

	Timer {
		interval: 10000
		running: true
		repeat: true
		onTriggered: batProc.running = true
	}
}
