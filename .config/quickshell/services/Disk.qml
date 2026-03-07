import Quickshell
import Quickshell.Io
import QtQuick

Scope {
	id: root

	property string path

	property real total 
	property real free
	property real used
	readonly property string totalPretty: formatBytes(total)
	readonly property string freePretty: formatBytes(free)
	readonly property string usedPretty: formatBytes(used)

	property double percentage: total > 0 ? (used / total).toFixed(4) : 0.0

	function formatBytes(bytes) {
		const kib = 1024
		const mib = 1024 ** 2
		const gib = 1024 ** 3
		const tib = 1024 ** 4

		if (bytes >= tib)
			return (bytes / tib).toFixed(2) + " TiB"
			
		if (bytes >= gib)
			return (bytes / gib).toFixed(2) + " GiB"

		if (bytes >= mib)
			return (bytes / mib).toFixed(2) + " MiB"

		return (bytes).toFixed(2) + " KiB"
	}

	Process {
		id: diskProc
		command: ["sh", "-c", `df -B1 ${root.path} | awk 'NR==2 {print $2 \" \" $3 \" \" $4}'`]
		running: true

		stdout: StdioCollector {
			onStreamFinished: {
				const raw = this.text.trim().split(/\s+/)

				function formatBytes(bytes) {
					const kib = 1
					const mib = 1024 ** 1
					const gib = 1024 ** 2
					const tib = 1024 ** 3

					if (bytes >= tib)
						return (bytes / tib).toFixed(2) + " TiB"
						
					if (bytes >= gib)
						return (bytes / gib).toFixed(2) + " GiB"

					if (bytes >= mib)
						return (bytes / mib).toFixed(2) + " MiB"

					if (bytes >= kib)
						return (bytes / kib).toFixed(2) + " KiB"

					return (bytes).toFixed(2) + " B"
				}

				root.total = parseFloat(raw[0])
				root.free = parseFloat(raw[2])
				root.used = parseFloat(raw[1])
			}
		}
	}

	Timer {
		interval: 300000
		running: true
		repeat: true
		onTriggered: diskProc.running = true
	}
}
