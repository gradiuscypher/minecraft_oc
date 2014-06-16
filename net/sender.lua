local component = require("component")
local event = require("event")

local m = component.modem

io.write("What is the address, enter bcast for broadcast: ")
addr = io.read()
io.write("What is the port you're sending to: ")
port = io.read()
io.write("What is the message you're sending: ")
msg = io.read()

m.send()