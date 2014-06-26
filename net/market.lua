require("dns_client")
require("dns_client")
component = require("component")
event = require("event")
serial = require("serialization")
modem = component.modem

addr = dns_lookup("market")

dict = {["action"]="create", ["target"]="gradius", ["password"]="test123"}
msg = serial.serialize(dict)

modem.send(addr, 8080, msg)
modem.open(8080)
local _,_,from,port,_,message = event.pull("modem_message")
print(message)
