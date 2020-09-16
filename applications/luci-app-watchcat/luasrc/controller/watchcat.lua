-- Copyright 2012 Christian Gagneraud <chris@techworks.ie>
-- Licensed to the public under the Apache License 2.0.

module("luci.controller.watchcat", package.seeall)

function index()
   if not nixio.fs.access("/etc/config/system") then
      return
   end
   entry({"admin", "system", "watchcat"}, cbi("watchcat/watchcat"), _("Automatic Recovery"), 10)
end
