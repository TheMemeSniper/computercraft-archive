function log(msg)
    print(os.time().." - "..msg)
end

function startMining()
    mineRow("up") -- first row
    rowNav("right")
    mineRow("up") -- second row
    rowNav("left")    
    mineRow("up") -- third row
    rowNav("up3")
    mineRow("down")
    rowNav("midcorn")
    mineRow("down")
    rowNav("midcorn")
    mineRow("down")
    rowNav("midcorn")
    mineRow("down")
    rowNav("midcorn") -- navigate to inner rows
    rowNav("midcorn")
    mineRow("down")
    rowNav("midu")
    mineRow("down")
    rowNav("midcorn")
    rowNav("midcorn")
    mineRow("down")
    rowNav("midu")
    mineRow("down")
    rowNav("midcorn")
    rowNav("midcorn")
    rowNav("midcorn")
    mineRow("down")
    rowNav("midu")
    mineRow("down")
    rowNav("midcorn")
    rowNav("midcorn")
    mineRow("down")
    rowNav("midu")
    mineRow("down")
    rowNav("up1")
    mineRow("down")
    rowNav("right")
    mineRow("down")
    rowNav("left")
    mineRow("down")
    rowNav("dropoff")
    os.sleep(1)
    rowNav("home")
end

function rowNav(direction)
    if direction == "left" then
        turtle.turnLeft()
        for i=1,3 do
            turtle.forward()
        end
        turtle.turnLeft()
    elseif direction == "right" then
        turtle.turnRight()
        for i=1,3 do
            turtle.forward()
        end
        turtle.turnRight()
    elseif direction == "up3" then
        turtle.forward()
        turtle.forward()
        for i=1,3 do
            turtle.up()
        end
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
        turtle.forward()
        turtle.forward()
    elseif direction == "midcorn" then
        turtle.forward()
        turtle.turnRight()
        turtle.forward()
    elseif direction == "midu" then
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    elseif direction == "up1" then
        turtle.up()
        turtle.turnRight()
        turtle.forward()
        turtle.turnRight()
    elseif direction == "dropoff" then
        turtle.forward()
        turtle.forward()
        for i=1,3 do
            turtle.down()
        end
        turtle.turnLeft()
        for i=1,6 do
            turtle.forward()
        end
    elseif direction == "home" then
        turtle.turnLeft()
        turtle.forward()
        turtle.down()
        for i=1,7 do
            turtle.forward()
        end
        turtle.turnRight()
        turtle.forward()
        turtle.select(2)
        turtle.suck()
        turtle.refuel()
        turtle.drop()
        turtle.select(1)
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    else
        error(direction.." is not a valid direction for rowNav")
    end
end

function mineRow(direction)
    for i=1,3 do
        ameMine(direction)
        turtle.forward()
        ameMine(direction)
        turtle.forward()
        ameMine(direction)
    end
end

function ameMine(dir)
    if ameExist(dir) then
        if dir == "up" then
            turtle.digUp()
        elseif dir == "down" then
            turtle.digDown()
        else
            error(dir.." is not a valid direction for ameMine")
        end
        return true  
    else
        return false
    end
end

function ameExist(side)
    if side == "up" then
        return turtle.compareUp("minecraft:amethyst_cluster")
    elseif side == "down" then
        return turtle.compareDown("minecraft:amethyst_cluster")
    else
        error(side.." is not a valid side for mineRow")
    end
end

log("starting up")
log("please put an amethyst cluster in the selected slot")
os.pullEvent("turtle_inventory")
if (turtle.getItemDetail().name ~= "minecraft:amethyst_cluster") then error("selected item is not an amethyst cluster") end
runs = 0
while true do
    runs = runs + 1
    log("beginning run "..runs)
    startMining()
    log("finished run "..runs)
    os.sleep(300)
end
