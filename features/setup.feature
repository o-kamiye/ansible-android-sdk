Feature: Install Android SDK on Debian/CentOS Linux Distro with Emulator

	Background: 
		Given that I have a running linux server
		And I provision it

	Scenario:
		When I install dependencies (e.g. Java, Git, etc)
		Then it should be successful

	Scenario:
		When I download Android build tools 
		And I update sdk from downloaded tools
		Then it should be successful

	Scenario:
		When I configure Android environment
		Then it should be successful

	Scenario:
		When I create AVD
		Then is should be successful
		And I should be able to access the internet from the device

