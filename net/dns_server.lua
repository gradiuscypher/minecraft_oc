--DNS Server for Minecraft Network
event = require("event")
component = require("component")
serialization = require("serialization")
modem = component.modem
modem.open(53)
dns_book = "/mnt/2dc/code/net/dns_book.txt"
book = {}

function load_book_from_file ()
    local file = io.open(dns_book, "r")
    local read_file = file.read(file)
    file:close()
    print("Done loading book from file.")
    return serialization.unserialize(read_file)
end

function save_book_to_file (book_obj)
    local file_write = assert(io.open(dns_book, "w"))
    local out_str = serialization.serialize(book_obj)
    file_write:write(out_str)
    file_write:close()
end

function lookup_request (from, port, name)
    print("[LOOKUP] "..from..":"..port.." - "..name)
    local addr = book[name]
    modem.send(from, port, addr)
end

function register_request(from, port, name)
    print("[REGISTER] "..from..":"..port.." - "..name.." = "..from)
    book[name] = from
    save_book_to_file(book)
end

function main ()
    book = load_book_from_file()
    event.listen("modem_message", function (_,_,from,port,_,message)
        request, name = message:match("([^,]+),([^,]+)")
        if request == "lookup" then
            lookup_request(from, port, name)
        elseif request == "register" then
            register_request(from, port, name)
        end
    end)
end

main()