require("dns_client")
component = require("component")
event = require("event")
serial = require("serialization")
modem = component.modem
addr = dns_lookup("market")
version = "0.1"

function login_screen ()
    os.execute("clear")
    print("")
    print("")
    print("")
    print("Logging into Market "..version)
    io.write("[l]ogin/[r]egister: ")
    action = io.read()
    
    if action == "login" or action == "l" then
        io.write("Username: ")
        user = io.read()
        io.write("Password: ")
        local password = io.read()
        local dict = {["action"]="login", ["target"]=user, ["password"]=password}
        local msg = serial.serialize(dict)        
        modem.send(addr, 8080, msg)
        modem.open(8080)
        local _,_,from,port,_,message = event.pull("modem_message")
        return serial.unserialize(message)
        
    elseif action == "register" or action == "r" then
        local password = ""
        local rpassword = "1"
        io.write("Username: ")
        local user = io.read()
        
        while password ~= rpassword do
            io.write("Password: ")
            password = io.read()
            io.write("Repeat password: ")
            rpassword = io.read()
            if password ~= rpassword then
                print("Passwords do not match.")
                print("")
            end
        end
               
        dict = {["action"]="create", ["target"]=user, ["password"]=password}
        msg = serial.serialize(dict)
        
        modem.send(addr, 8080, msg)
        modem.open(8080)
        local _,_,from,port,_,message = event.pull("modem_message")
        return serial.unserialize(message)
    end
end

function main ()
    user_logged_in = false
    
    while true do
        login_result = login_screen()
        
        if login_result["action"] == "login" and login_result["status"] == true then
            user_logged_in = true
            
        elseif login_result["action"] == "register" then
            print("User register, you can now login.")
            os.sleep(1)
        end
        
        if user_logged_in then
            print("YAY WE LOGGED IN")
            os.sleep(1)
        end
    end
end

main()
