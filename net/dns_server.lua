--DNS Server for Minecraft Network
event = require("event")
component = require("component")
modem = component.modem

modem.open(53)

event.listen("modem_message", function (_,_,from,port,_,message)
    print(message)
    request, name, address, pin = message:match("([^,]+),([^,]+),([^,]+),([^,]+)")
    
    if request == "lookup" then
        print("Lookup request:"..from..":"..port)
        lookup_request(from, port, name)
    elseif request == "register" then
        print("Register request:"..from..":"..port)
        register_request(from, port, name, address)
    elseif request == "update" then
        print("Update request:"..from..":"..port)
        update_request(from, port, name, address, pin)        
    end
end)

function lookup_request (from, port, name)
    print("Got request to look up "..name)
    modem.send(from, port, "TEST-ADDRESS123")
end

function register_request(from, port, name, address, pin)
    print("got request to register "..name.." to "..address)
end

function update_request(from, port, name, address, pin)
    print("got request to update "..name.." to "..address.." using "..pin)
end