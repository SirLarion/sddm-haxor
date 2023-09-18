import QtQuick 2.15

Item {
	property string hostName: "sddm-test"

	property bool canPowerOff: true
	property bool canReboot: true
	property bool canSuspend: true
	property bool canHibernate: true
	property bool canHybridSleep: true

	function login(user, password, sessionIndex)
	{
		console.log("Failing, test mode")
		loginFailed()
	}

	function powerOff()
	{
		console.log("Powering off")
	}

	function reboot()
	{
		console.log("Rebooting")
	}

	function suspend()
	{
		console.log("Suspending")
	}

	function hibernate()
	{
		console.log("Hibernating")
	}

	function hybridSleep()
	{
		console.log("Hybrid sleeping")
	}

	signal loginSucceeded()

	signal loginFailed()
}
