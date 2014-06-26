require("dns_client")
component = require("component")
event = require("event")
serial = require("serialization")
modem = component.modem
market_users = "/code/net/marketd/users.txt"
users_dict = {}


function handle_input ()
    --Packet Structure:
    --["action"] = ACTION (create, login)
    --["target"] = TARGET (username)
    --["password"] = PASSWORD
    local _,_,from,port,_,message = event.pull("modem_message")
    msg_dict = serial.unserialize(message)
    print("MESSAGE: "..message)
    
    if msg_dict["action"] == "create" then
        if users_dict[msg_dict["target"]] == nil then
            users_dict[msg_dict["target"]] = msg_dict["password"]
            save_user_dict(users_dict)
            return_dict = {["msg"] = "User created successfully", ["status"] = true}
            return_msg = serial.serialize(return_dict)
            modem.send(from, 8080, return_msg)
        else
            return_dict = {["msg"] = "User creation failed.", ["status"] = false}
            return_msg = serial.serialize(return_dict)
            modem.send(from, 8080, return_msg)
        end
    elseif msg_dict["action"] == "login" then
        print("login")
    end
end

function load_user_dict ()
    local file = io.open(market_users, "r")
    local read_file = file.read(file)
    file:close()
    print("Done loading users from file.")
    return serial.unserialize(read_file)
end

function save_user_dict (obj)
    local file_write = assert(io.open(market_users, "w"))
    local out_str = serial.serialize(obj)
    file_write:write(out_str)
    file_write:close()
end

function init ()
    dns_register("market")
    modem.open(8080)
    users_dict = load_user_dict()
end

function main ()
    init()
    
    while true do
        handle_input()
    end
end

main()