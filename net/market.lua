require("dns_client")
require("dns_client")
component = require("component")
event = require("event")
serial = require("serialization")
modem = component.modem

addr = dns_lookup("market")





while true do
    io.write("Action: ")
    action = io.read()
    io.write("Username: ")
    user = io.read()
    io.write("Password: ")
    password = io.read()
    
    dict = {["action"]=action, ["target"]=user, ["password"]=password}
    msg = serial.serialize(dict)
    
    modem.send(addr, 8080, msg)
    modem.open(8080)
    local _,_,from,port,_,message = event.pull("modem_message")
    print(message)
end