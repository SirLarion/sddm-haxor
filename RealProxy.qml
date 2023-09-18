import QtQuick 2.15

Item {
	id: realProxy

	property string hostName: sddm.hostName

	property bool canPowerOff: sddm.canPowerOff
	property bool canReboot: sddm.canReboot
	property bool canSuspend: sddm.canSuspend
	property bool canHibernate: sddm.canHibernate
	property bool canHybridSleep: sddm.canHybridSleep

	function powerOff() { sddm.powerOff() }
	function reboot() { sddm.reboot() }
	function suspend() { sddm.suspend() }
	function hibernate() { sddm.hibernate() }
	function hybridSleep() { sddm.hybridSleep() }

	function login(user, password, sessionIndex)
	{
		sddm.login(user, password, sessionIndex)
	}

	signal loginSucceeded()

	signal loginFailed()

	Connections {
		target: sddm

		function onLoginFailed()
		{
			realProxy.loginFailed()
		}

		function onLoginSucceeded()
		{
			realProxy.loginSucceeded()
		}
	}
}
