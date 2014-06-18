--DNS client for Minecraft network
--server_address = "9ca3b064-0c83-4c20-845d-8cb282cf560b"
server_address = "0b11c691-56e7-421a-bd79-8f0a8f3cb873"
component = require("component")
event = require("event")
modem = component.modem

function dns_lookup (name)
    modem.open(53)
    modem.send(server_address, 53, "lookup,"..name)
    local _,_,from,port,_,message = event.pull("modem_message")
    modem.close(53)
    return message
end

function dns_register (name)
    modem.send(server_address, 53, "register,"..name)
end
