require("dns_client")
component = require("component")
event = require("event")
shell = require("shell")
filesystem = require("filesystem")

modem = component.modem
modem.open(22)

function main ()
    print("Starting SSHd on port 22")
    event.listen("modem_message", function (_,_,from,port,_,message)   
        request, command = message:match("([^,]+),([^,]+)")
        if request == "ssh" then
            if command == "ls" then
                local result = ""
                for fi in filesystem.list(shell.getWorkingDirectory()) do result = result.." "..fi end
                modem.send(from, port, tostring(result))
            elseif command == "pwd" then
                modem.send(from, port, shell.getWorkingDirectory())
            else
                result,err = shell.execute(command)
                modem.send(from, port, tostring(result)..":"..tostring(err))
                print("[SSH]:"..command)
                print("<RES>:"..result.."-"..err)
            end
        end
    end)
end

main()
