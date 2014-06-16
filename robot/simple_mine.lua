function walk_to_mine (steps)
    local robot = require("robot")
    local z_loc = 0
    -- Walk forward 6 steps away from the mining house
    -- This is where mining starts
    local i = 0
    while i < steps do
        robot.forward()
        i = i + 1
    end
    
    -- Float down until you hit the ground
    while not robot.detectDown() do
        robot.down()
        z_loc = z_loc - 1
    end
    
    return z_loc
end

function mine_count (total, z_ini)
    local robot = require("robot")
    local count = 1
    local x_loc = 0
    local y_loc = 0
    local z_loc = z_ini
    
    while count <= total do
        while x_loc < 6 do
            while y_loc <= 5 do
                robot.swingDown()
                robot.forward()
                y_loc = y_loc + 1
            end
            
            robot.swingDown()
            robot.turnRight()
            robot.forward()
            robot.turnRight()
            x_loc = x_loc + 1
            
            while y_loc > 0 do
                robot.swingDown()
                robot.forward()
                y_loc = y_loc - 1
            end
            
            robot.swingDown()
            robot.turnLeft()
            robot.forward()
            robot.turnLeft()
            x_loc = x_loc + 1            
        end
        print("Done with loop forwards")
        
        robot.down()
        z_loc = z_loc - 1
        
        while x_loc > 0 do
            while y_loc <= 5 do
                robot.swingDown()
                robot.forward()
                y_loc = y_loc + 1
            end
            
            robot.swingDown()
            robot.turnLeft()
            robot.forward()
            robot.turnLeft()
            x_loc = x_loc - 1
            
            while y_loc > 0 do
                robot.swingDown()
                robot.forward()
                y_loc = y_loc - 1
            end
            
            robot.turnRight()
            robot.forward()
            robot.turnRight()
            x_loc = x_loc - 1

        end
        print("Done with loop backwards")
        print("Count:")
        print(count)
        count = count + 1
        
    end
    print("I'm done mining")
    print(z_loc)    
    return z_loc
end

function walk_to_charger (z_ini)
    print("Walking to charger")
    print(z_ini)
    local robot = require("robot")
    z_loc = z_ini
    
    while z_loc < 0 do
        robot.up()
        z_loc = z_loc + 1
    end
    
    robot.back()
end

function walk_to_storage ()
end

function main ()
    z_ini = walk_to_mine(12)
    z_loc = mine_count(1,z_ini)
    walk_to_charger(z_loc)
end

main()