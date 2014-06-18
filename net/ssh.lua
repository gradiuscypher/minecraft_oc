require("dns_client")
component = require("component")
event = require("event")
modem = component.modem
modem.open(22)

io.write("What is the address: ")
addr = io.read()
hw_addr = dns_lookup(addr)

while true do
    io.write("> ")
    command = io.read()
    modem.send(hw_addr, 22, "ssh,"..command)
    local _,_,from,port,_,message = event.pull("modem_message")
    print(message)
end
