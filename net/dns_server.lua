--DNS Server for Minecraft Network
event = require("event")
component = require("component")
serialization = require("serialization")
modem = component.modem
book = {}
modem.open(53)
dns_book = "/mnt/2dc/code/net/dns_book.txt"


event.listen("modem_message", function (_,_,from,port,_,message)
    print(message)
    request, name, address, pin = message:match("([^,]+),([^,]+),([^,]+),([^,]+)")
    
    if request == "lookup" then
        lookup_request(from, port, name)
    elseif request == "register" then
        print("Register request:"..from..":"..port)
        register_request(from, port, name, address)
    elseif request == "update" then
        print("Update request:"..from..":"..port)
        update_request(from, port, name, address, pin)        
    end
end)

function load_book_from_file ()
    local file = io.open(dns_book, "r")
    local read_file = io.read("*all")
    return serialization.unseralize(read_file)
end

function save_book_to_file (book_obj)
    local file_write = assert(io.open(dns_book, "w"))
    out_str = serialization.serialize(book_obj)
    file_write:write(out_str)
    file_write:close()
end

function lookup_request (from, port, name)
    print("[LOOKUP] "..from..":"..port.." - "..name)
    modem.send(from, port, "TEST-ADDRESS123")
end

function register_request(from, port, name, address, pin)
    print("got request to register "..name.." to "..address)
end

function update_request(from, port, name, address, pin)
    print("got request to update "..name.." to "..address.." using "..pin)
end