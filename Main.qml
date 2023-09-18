/*
sddm-haxor - A simple SDDM theme for the cli-based haxor chads
Copyright (C) 2023 Miska Tammenpää

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import QtQuick 2.15
import QtQuick.Controls 2.15

import "components"

Rectangle {
  id: terminalArea
  anchors.fill: parent

  width: config.screenWidth
  height: config.screenHeight

  color: config.background

  state: "login"

  states: [
    State {
      name: "login"
      PropertyChanges {
        target: loginForm
        visible: true
      }
    }
  ]

  Proxy {
    id: proxy
  }

  Column {
    id: terminalForm
    anchors.fill: parent

    visible: false

    Login {
      id: loginForm
      visible: false
    }
  }

  Timer {
    // Initially the hostname didn't appear, giving it some time
    running: true
    repeat: true
    interval: 100
    property int timePassed: 0
    onTriggered: {
      timePassed += interval

      if (
        (proxy.hostName.length > 0)
        || (timePassed >= 1000)
      )
      {
        terminalForm.visible = true
        stop()
      }
    }
  }

  Connections {
    target: proxy
    function onLoginSucceeded()
    {
      terminalForm.visible = false
    }
  }

  Connections {
    target: loginForm
    function onCredentialsEntered(username, password)
    {
      proxy.login(username, password, sessionModel.lastIndex)
    }
  }

  MouseArea {
    anchors.fill: parent
    enabled: false
    cursorShape: Qt.BlankCursor
  }
}
