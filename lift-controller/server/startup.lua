local CONFIG = {
    TX = 1337,
    RX = 1336,
    GANTRYSIDE = "back", -- Set this side to the side of the computer that connects to the gantry via redstone
    GEARSHIFTSIDE = "left", -- Set this side to the side of the computer that connects to the gearshift via redstone
}

function split(inputstr, sep)
   -- if sep is null, set it as space
   if sep == nil then
      sep = '%s'
   end
   -- define an array
   local t={}
   -- split string based on sep   
   for str in string.gmatch(inputstr, '([^'..sep..']+)') 
   do
      -- insert the substring in table
      table.insert(t, str)
   end
   -- return the array
   return t
end

local strbool = {["true"]=true, ["false"]=false}

local direction = false



local modem = peripheral.find("modem") or error("No modem attached", 0)
modem.open(CONFIG.RX)

while true do
   local event, side, channel, replyChannel, message, distance
   repeat
      event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
   until channel == CONFIG.RX

   if replyChannel ~= CONFIG.TX then return end

   local recieved = tostring(message)

   local command = split(recieved, "|")

   print(recieved)

   if command[1] == "LIFT:ACTUATE" then
      redstone.setOutput(CONFIG.GANTRYSIDE, false)
      sleep(tonumber(command[2]) * 0.05)
      redstone.setOutput(CONFIG.GANTRYSIDE, true)
   elseif command[1] == "LIFT:SETDIR" then
      local toggle = strbool[command[2]]
      if toggle == nil then return end
      direction = toggle
      redstone.setOutput(CONFIG.GEARSHIFTSIDE, direction)
   elseif command[1] == "LIFT:GETDIR" then
      modem.transmit(CONFIG.TX, CONFIG.RX, direction)
   elseif command[1] == "LIFT:SETON" then
      local toggle = strbool[command[2]]
      if toggle == nil then return end
      direction = toggle
      redstone.setOutput(CONFIG.GANTRYSIDE, toggle)
   end
end



