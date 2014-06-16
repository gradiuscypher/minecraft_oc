--ARP Functions, to be run during boot
component = require("component")
event = require("event")
modem = component.modem

function arp_listen()
    modem.open(1)
    event.listen("modem_message", function(a,b,c,d,e,f)
        print(a,b,c,d,e,f)
    end)
end

function arp_broadcast()
    print("Broadcasting ARP")
end