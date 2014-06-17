require("dns_client")
component = require("component")
event = require("event")
shell = require("shell")
tmp_file = "/tmp/shell_last_out"

modem = component.modem
modem.open(22)

function main ()
    event.listen("modem_message", function (_,_,from,port,_,message)
        request, command = message:match("([^,]+),([^,]+)")
        if request == "ssh" then
            shell.execute(message.." > "..tmp_file)
            local file = io.open(tmp_file, "r")
            local read_file = file.read(file)
            modem.send(from, port, read_file)
            file:close()
            print("[SSH] "..command..">"..read_file)
        end
    end)
end

main()
