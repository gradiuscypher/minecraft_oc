local component = require("component")
local event = require("event")

local m = component.modem

m.open(123)

while true do
    local a,b,c,d,e,f = event.pull("modem_message")
    print(a,b,c,d,e,f)
end