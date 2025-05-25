local CONFIG = {
    TX = 1336,
    RX = 1337,
    FLOORWAIT = 13 
    --[[
        Amount of time in ticks that a lift needs to travel to the next floor 
        (At 256 RPM a gantry shaft moves carriages at 0.5 blocks per second)
    ]] 
}

function writeLog(s, pos)
    if not pos then 
        pos = {1,2} 
    end
    term.setBackgroundColor(colors.black)
    term.setCursorPos(pos[1],pos[2])
    term.clearLine()
    term.write(s)
end

local dirmap = {[true] = "down", [false] = "up"}

local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(CONFIG.TX)

paintutils.drawFilledBox(3,6,6,8, colors.green)
paintutils.drawFilledBox(3,10,6,12, colors.red)
paintutils.drawFilledBox(6,6,9,8, colors.blue)

local toggle = false

local liftGo = false


while true do
    local event, button, x, y = os.pullEvent("mouse_click")

    
    if x >= 3 and x <= 6 and y >= 6 and y <= 8 then
        -- Green button
        modem.transmit(CONFIG.TX, CONFIG.RX, "LIFT:ACTUATE|13")
        writeLog("Moved 1 floor")
    elseif x >= 3 and x <= 6 and y >= 10 and y <= 12 then
        -- Red button
        toggle = not toggle
        modem.transmit(CONFIG.TX, CONFIG.RX, "LIFT:SETDIR|"..tostring(toggle))
        writeLog("Lift direction set to "..dirmap[toggle])
        writeLog("Going "..dirmap[toggle], {1,3})
    elseif x >= 6 and x <= 9 and y >= 6 and y <= 8 then
        -- Blue toggle
        liftGo = not liftGo
        modem.transmit(CONFIG.TX, CONFIG.RX, "LIFT:SETON|"..tostring(liftGo))
        writeLog("Lift brake set to "..tostring(liftGo))
        if liftGo then
            writeLog("Lift brake disabled", {1,4})
        else
            writeLog("", {1,4})
        end
                
    end

end

