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
	mineRingRow("right", "down")
    rowNav("rightmid")
    mineRingRow("right", "down")
    rowNav("leftmid")
    mineRingRow("right", "down")
    rowNav("dropoff")
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
    elseif direction == "rightmid" then
        turtle.forward()
        turtle.turnRight()
        turtle.forward()
        turtle.forward()
        turtle.forward()
        turtle.forward()
        turtle.forward()
        turtle.turnRight()
        turtle.forward()
    elseif direction == "leftmid" then
        turtle.turnLeft()
        turtle.forward()
        turtle.turnLeft()
    elseif direction == "dropoff" then
        turtle.forward()
        for i=1,3 do
            turtle.down()
        end
        turtle.turnLeft()
        turtle.turnLeft()
        for i=1,8 do
            turtle.forward()
        end
        turtle.up()
        turtle.forward()
        turtle.turnLeft()
        turtle.forward()
        os.sleep(1)
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

function mineRingRow(face, direction)
    for i=1,2 do
        mineRing(face, direction)
        for i=1,3 do
            turtle.forward()
        end
    end
    mineRing(face, direction)
end

function mineRing(face, direction)
	if (face == "left") then
        turtle.turnLeft()
        ameMine("forward")
        turtle.turnRight()
		for i=1,4 do
			ameMine(direction)
			turtle.forward()
			turtle.turnLeft()
			turtle.forward()
			ameMine(direction)
		end
	elseif (face == "right") then
        turtle.turnRight()
        ameMine("forward")
        turtle.turnLeft()
		for i=1,4 do
			ameMine(direction)
			turtle.forward()
			turtle.turnRight()
			turtle.forward()
			ameMine(direction)
		end
	else
		error(face.." is not a valid face for mineRing")
	end
end

function ameMine(dir)
    if ameExist(dir) then
        if dir == "up" then
            turtle.digUp()
        elseif dir == "down" then
            turtle.digDown()
        elseif dir == "forward" then
            turtle.dig()
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
    elseif side == "forward" then
        return turtle.compare("minecraft:amethyst_cluster")
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
