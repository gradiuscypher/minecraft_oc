--Commands to run on boot to configure a headless server
shell = require("shell")
shell.execute("cd /code")
require("dns_client")

shell.execute("/code/dnsd.lua")
shell.execute("/code/sshd.lua")

dns_register("server1")