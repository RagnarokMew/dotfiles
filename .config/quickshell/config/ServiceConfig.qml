import Quickshell.Io
import QtQuick

JsonObject {
	property bool cpuEnabled: true
	property bool gpuEnabled: true
	property bool memEnabled: true
	property bool uptimeEnabled: true

	property int batTimer: 10000
	property int cpuTimer: 10000
	property int diskTimer: 300000
	property int gpuTimer: 10000
	property int memTimer: 60000
	property int uptimeTimer: 60000
}
