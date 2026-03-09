pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import config

Scope {
	id: root

	property bool _enabled: Config.services.cpuEnabled

	property string name: ""
	property real temp: 0.0
	property real percentage: 0.0

	property real lastCpuIdle: 0.0
	property real lastCpuTotal: 0.0 

	function cleanCpuName(name: string): string {
		return name.replace(/\(R\)/gi, "").replace(/\(TM\)/gi, "").replace(/CPU/gi, "").replace(/\d+th Gen /gi, "").replace(/\d+nd Gen /gi, "").replace(/\d+rd Gen /gi, "").replace(/\d+st Gen /gi, "").replace(/Core /gi, "").replace(/Processor/gi, "").replace(/\s+/g, " ").trim();
  }

	// One-time cpu name
	FileView {
		id: cpuinfo

		path: "/proc/cpuinfo"
		onLoaded: {
				if (!root._enabled) return;

				const nameMatch = text().match(/model name\s*:\s*(.+)/);
				if (nameMatch)
						root.name = root.cleanCpuName(nameMatch[1]);
		}
  }

	FileView {
		id: stat

		path: "/proc/stat"
		onLoaded: {
			if (!root._enabled) return;

			const data = text().match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);

			if (data) {
				const stats = data.slice(1).map(n => parseInt(n, 10));
				const total = stats.reduce((a, b) => a + b, 0);
				const idle = stats[3] + (stats[4] ?? 0);

				const totalDiff = total - root.lastCpuTotal;
				const idleDiff = idle - root.lastCpuIdle;
				root.percentage = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0;

				root.lastCpuTotal = total;
				root.lastCpuIdle = idle;
			}
		}
  }

	Process {
		id: cpuTempProc
		command: ["sensors"]
		running: root._enabled

		stdout: StdioCollector {
			onStreamFinished: {
				let cpuTemp = text.match(/(?:Package id [0-9]+|Tdie):\s+((\+|-)[0-9.]+)(°| )C/);
				if (!cpuTemp)
					// If AMD Tdie pattern failed, try fallback on Tctl
					cpuTemp = text.match(/Tctl:\s+((\+|-)[0-9.]+)(°| )C/);

				if (cpuTemp)
					root.temp = parseFloat(cpuTemp[1]);
			}
		}
	}

	Timer {
		interval: 10000
		running: root._enabled
		repeat: root._enabled
		onTriggered: {
			stat.reload();
			cpuTempProc.running = true;
		}
	}
}
