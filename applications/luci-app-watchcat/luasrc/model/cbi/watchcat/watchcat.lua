-- Copyright 2012 Christian Gagneraud <chris@techworks.ie>
-- Licensed to the public under the Apache License 2.0.

m = Map("system", 
	translate("Automatic Recovery Actions"), 
	translate("Here you can set up several actions to take based on network events, such as a loss of connectivity to a host. " ..
		"Click the <b>Add</b> button at the bottom to set up more than one action."))

s = m:section(TypedSection, "watchcat", "Automatic Recovery Rules", "These rules will govern how the router recovers from network events." ..
" In most situations, we recommend having at least one Network Restart rule, so one has been set up by default.")
s.anonymous = true
s.addremove = true

mode = s:option(ListValue, "mode",
		translate("Mode"))
mode.default = "network"
mode:value("ping", "Ping Reboot: Reboot this router if a host is unreachable")
mode:value("always", "Periodic Reboot: Reboot this router periodically at a set interval of time")
mode:value("network", "Network Restart: Restart the mobile network connection if a host is unreachable")

period = s:option(Value, "period", 
		  translate("Period"),
		  translate("In 'Periodic Reboot' mode, it defines how often to reboot. <br>" ..
			    "In 'Ping Reboot' mode, it defines the longest period of " .. 
				"time without a reply from the Host To Check before a reboot is engaged. <br>" ..
				"In 'Network Restart' mode, it defines the longest period of " .. 
				"time without a reply from the Host to Check before the mobile data connection is restarted." ..
			    "<br><br>The default unit is seconds, with no suffix, but you can use the " ..
			    "suffix 'm' for minutes, 'h' for hours or 'd' " ..
			    "for days. <br><br>Examples:<ul><li>10 seconds would be: 10</li><li>5 minutes would be: 5m</li><li>1 hour would be: 1h</li><li>1 week would be: 7d</li><ul>"))

pinghost = s:option(Value, "pinghosts", 
		    translate("Host To Check"),
		    translate("IP address or hostname to ping. <br><br> Examples are 8.8.8.8 or cloud.telcoantennas.com.au"))
pinghost.datatype = "host(1)"
pinghost.default = "cloud.telcoantennas.com.au"

pingperiod = s:option(Value, "pingperiod", 
		      translate("Check Interval"),
		      translate("How often to ping the host specified above. " ..
			    "<br><br>The default unit is seconds, with no suffix, but you can use the " ..
			    "suffix 'm' for minutes, 'h' for hours or 'd' " ..
			    "for days. <br><br>Examples:<ul><li>10 seconds would be: 10</li><li>5 minutes would be: 5m</li><li>1 hour would be: 1h</li><li>1 week would be: 7d</li><ul>"))


advanced = s:option(Flag, "advanced", "Advanced", "Show advanced options")
advanced.default = "0"

pingsize = s:option(ListValue, "pingsize", 
		      translate("Ping Packet Size"),
		      translate("<i>Applies to Ping Reboot and Network Restart modes</i> <br> Save data by sending smaller ping packets, "  ..
				"or check that the link can carry large packets without fragmenting by using large packets. " ..
				"Test with standard sized ping traffic by using the standard packet size."))
pingsize:value("small", "Small: 1 byte")
pingsize:value("standard", "Standard: 56 bytes")
pingsize:value("big", "Big: 88 bytes")
pingsize.default = "small"
pingsize:depends({advanced="1"})

forcedelay = s:option(Value, "forcedelay",
		      translate("Forced Reboot Delay"),
		      translate("<i>Applies to Ping Reboot and Periodic Reboot modes</i> <br> When rebooting the router, the service will trigger a soft reboot. " ..
				"Entering a non-zero value here will trigger a delayed hard reboot " ..
				"if the soft reboot were to fail. Enter the number of seconds to wait for the soft reboot to fail " ..
				"or use 0 to disable the forced reboot delay."))
forcedelay.datatype = "uinteger"
forcedelay.default = "60"
forcedelay:depends({advanced="1"})


return m
