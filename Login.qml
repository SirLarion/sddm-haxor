import QtQuick 2.15
import QtQuick.Controls 2.15

import "components"

Rectangle {
	id: loginForm
  anchors {
    bottom: parent.verticalCenter
    bottomMargin: 160
    left: parent.left
    leftMargin: 160
  }

	Proxy {
		id: proxy
	}

	TermLabel {
		id: loginFailedLabel
		text: "Login incorrect"

		visible: false
	}

	Row {
    id: userNameRow

    TermLabel {
      id: usernameLabel
      text: "> "
    }

		TermInput {
			id: usernameInput

			focus: true

			text: ""

			onAccepted: {
				loginForm.setState("password")
			}
		}
	}

	Row {
		id: passwordRow
    
    anchors { 
      top: userNameRow.bottom
      topMargin: 8
    }

		visible: false

    TermLabel {
      id: passwordLabel
      text: "> "
    }

		TermInput {
			id: passwordInput

			echoMode: TextInput.Password
			text: ""
      passwordCharacter: "*"

			onAccepted: {
        loginForm.setState("authenticating")
			}
		}
	}

	Timer {
		// Ensuring the input box is always focused, as in a terminal.
		// If neither box visible, ensure they DON'T have focus
		// to prevent typing
		running: true
		repeat: true
		interval: 100
		onTriggered: {
			if (passwordInput.visible) {
				passwordInput.forceActiveFocus()
			}
			else if(usernameInput.visible) {
				usernameInput.forceActiveFocus()
			}
			else {
				loginForm.forceActiveFocus()
			}
		}
	}

	function setState(state) {
		switch (state) {
			case "loginFailed":
        loginFailedLabel.visible = true
        //fallthrough

			case "username":
        loginForm.visible = true
        usernameLabel.opacity = 1
        passwordLabel.opacity = 0
        passwordRow.visible = false
        usernameInput.readOnly = false
        usernameInput.text = ""
        break

			case "password":
        loginForm.visible = true
        passwordRow.visible = true
        usernameLabel.opacity = 0
        passwordLabel.opacity = 1
        usernameInput.readOnly = true
        passwordInput.readOnly = false
        passwordInput.text = ""
        passwordInput.forceActiveFocus()
        break

      case "authenticating":
        loginForm.forceActiveFocus()
        usernameLabel.opacity = 0
        passwordLabel.opacity = 0
				passwordInput.readOnly = true
				credentialsEntered(usernameInput.text, passwordInput.text)
        break

      default:
        break
		}
	}

	Connections {
		target: proxy
		function onLoginFailed() {
			loginForm.setState("loginFailed")
		}
	}

	Connections {
		target: Qt.inputMethod
		function onVisibleChanged() {
			// Prevent virtual keyboard from showing
			Qt.inputMethod.hide()
		}
	}

	signal credentialsEntered(string username, string password)
}
