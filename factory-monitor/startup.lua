local SETTINGS = {
    DISKPROTECT = false,
    NTFY_URL = "https://ntfy.sh/icannotgetagoodone",
}

local state = {
    OVERSTRESSED = false,
    DISKPROTECT_READY = false
}

local osPull = os.pullEvent

-- if it crashes here you forgot the sha256 library
-- originally copied from https://github.com/MaHuJa/CC-scripts/blob/master/sha256.lua
-- also at https://github.com/TheMemeSniper/computercraft-archive/factory-monitor/sha256.lua
-- copy this to /
require("sha256")

local target = peripheral.find("create_target")
local drive  = peripheral.find("drive")

if not target then
    print("Target monitoring features disabled, no target connected")
end

if SETTINGS.DISKPROTECT then
    os.pullEvent = os.pullEventRaw

    local keyExists = fs.exists("/key")
    if not keyExists then
        print("DISKPROTECT enabled but keyfile doesn't exist!")
        print("Computer not locked...")
        state.TERMINATE_ALLOWED = true
    end
    if not drive and keyExists then
        print("DISKPROTECT enabled but drive is not connected!")
        print("Reboot in 5 seconds...")
        os.sleep(5)
        os.reboot()
    end
    if drive and keyExists then
        state.DISKPROTECT_READY = true
        print("DISKPROTECT enabled, press SPACE with the key disk plugged in to terminate the program")
    end
end

function validateKeyDisk()
    if not drive then
        drive = peripheral.find("drive")
        if not drive then
            print("Drive is gone?")
            return false
        end
    end

    if fs.exists("/disk/key") then
        local diskKeyFile = fs.open("/disk/key", "r")
        local ourHashFile = fs.open("/key", "r")
        
        local diskKey = diskKeyFile.readLine()
        local ourHash = ourHashFile.readLine()

        diskKeyFile.close()
        ourHashFile.close()

        local keyHash = sha256(diskKey)
        if keyHash == ourHash then
            return true
        end
    end

    return false

end

function extractSUInfo(rawSU)
    local clean = string.gsub(rawSU, "su", "") -- remove su from string
    clean = string.gsub(clean, " ", "") -- remove unneccesary whitespace
    clean = string.gsub(clean, ",", "") -- remove commas
    return tonumber(clean)
end

function diskprotectKey()
    while true do
        local event, keycode = os.pullEvent()
        if event == "key" then
            if keycode == 32 then
                local valid = validateKeyDisk()
                if valid then -- god nest us all
                    print("authorized")
                    break
                else
                    print("bad key disk")
                end
            end
        end
    end
end

function main()
    while true do
        os.sleep(5)
        if target then
            local remainingSU = extractSUInfo(target.getLine(1))
            if remainingSU <= -1 and not state.OVERSTRESSED then
                print("Network overstress!")
                http.post(SETTINGS.NTFY_URL, "Network has entered overstress")
                state.OVERSTRESSED = true
            elseif remainingSU >=1 and state.OVERSTRESSED then
                print("Overstress resolved")
                http.post(SETTINGS.NTFY_URL, "Network overstress has been resolved")
                state.OVERSTRESSED = false
            end
        end
    end
end

print("Beginning monitoring loop")
if state.DISKPROTECT_READY then
    parallel.waitForAny(main, diskprotectKey)
else
    main()
end
