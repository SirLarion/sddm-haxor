import QtQuick 2.15
import QtQuick.Controls 2.15

TextInput {
	id: control
	font.family: config.fontFamily
	font.pointSize: config.fontSize
	color: config.foreground

	width: 500

	cursorDelegate: Label {
		id: cursor
		font.family: config.fontFamily
		font.pointSize: config.fontSize
		color: config.foreground
		text: "▁" // U+2521, lower one eighth block

		Timer {
			running: true
			repeat: true
			interval: 200
			onTriggered: cursor.visible = !cursor.visible && !control.readOnly
		}
	}

	onReadOnlyChanged: {
		if (readOnly)
		{
			cursorVisible = false
		}
	}
}
