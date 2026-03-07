pragma Singleton

import Quickshell
import QtQuick

QtObject {
	property var _clock: SystemClock {
		id: systemTime
		precision: SystemClock.Minutes
	}

	readonly property string timeStr: Qt.formatDateTime(systemTime.date, "hh:mm")
	readonly property string dateShortStr: Qt.formatDateTime(systemTime.date, "dd-MM")
}
