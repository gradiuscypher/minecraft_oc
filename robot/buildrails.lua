function check_inventory (next_stack)
    local r = require("robot")
    --Check that you have a stack of rails in 1, and that powered rails in 16
    if r.count(16) > 0 then
        if r.count() > 0 then
            --Return no error code, continue operation
            return 0
            
        elseif next_stack < 16 then
            --Ran out of rails in slot, so move to next_stack
            r.select(next_stack)
            print("Selecting next stack "..next_stack)
            --Return error code 1, indicating that the next_stack needs to be +1
            return 1
            
        else
            --If we hit slot 16, we have no more rails
            print("Ran out of rails")
            --Return 2, indicating that a fatal error has occurred.
            return 2
        end
        
    else
        --We've run out of powered rails
        print("I'm out of powered rails")
        --Return 2, indicating that a fatal error has occurred.
        return 2
    end    
end

function find_next_move ()
    --find whether the track turned left or right, and place yourself on the next track, facing the proper direction ready to place the next track
    --If no direction is found, halt the program
end

function main ()
    local rail_count = 0
    local next_stack = 2
    local r = require("robot")
    local should_loop = check_inventory(next_stack)
    
    r.up()
    
    while should_loop ~= 2 do
        if should_loop == 1 then
            next_stack = next_stack + 1
        end
        
        if rail_count == 0 then
            r.select(16)
            r.placeDown()
            rail_count = 38
            
            if verify_place then
                r.forward()
            end
        elseif r.count() > 0 then
            r.select(next_stack - 1)
            r.placeDown()
            rail_count = rail_count - 1
            
            if verify_place() then
                r.forward()
            end
        end
        
        should_loop = check_inventory(next_stack)
    end
end

function verify_place ()
    --Verify that a rail was placed and that we can move on
    --Otherwise, we'll need to find the direction of the track base
    if true then
        return true
    else
        find_next_move()
        return false
end

main()
