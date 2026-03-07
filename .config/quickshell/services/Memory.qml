pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Scope {
	id: root

	// RAM resources
	property real total
	property real used
	property real free
	readonly property real percentage: total > 0 ? (used / total).toFixed(4) : 0
	readonly property string totalPretty: formatKib(total)
	readonly property string usedPretty: formatKib(used)
	readonly property string freePretty: formatKib(free)

	function formatKib(kib) {
		const mib = 1024
		const gib = 1024 ** 2
		const tib = 1024 ** 3

		if (kib >= tib)
			return (kib / tib).toFixed(2) + " TiB"
			
		if (kib >= gib)
			return (kib / gib).toFixed(2) + " GiB"

		if (kib >= mib)
			return (kib / mib).toFixed(2) + " MiB"

		return (kib).toFixed(2) + " KiB"
	}

	FileView {
		id: meminfo

		path: "/proc/meminfo"

		onLoaded: {
			const data = text();
			root.total = parseInt(data.match(/MemTotal: *(\d+)/)[1], 10) || 1;
			root.free = parseInt(data.match(/MemAvailable: *(\d+)/)[1], 10) || 1;
			root.used = (root.total - root.free)
		}
	}

	Timer {
		interval: 60000
		running: true
		repeat: true
		onTriggered: {
			meminfo.reload();
		}
	}
}
