-- this program requires the sha256 library
-- originally copied from https://github.com/MaHuJa/CC-scripts/blob/master/sha256.lua
-- also at https://github.com/TheMemeSniper/computercraft-archive/factory-monitor/sha256.lua
-- copy this to /
require("sha256")

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

local drive = peripheral.find("drive")
if not drive then
    print("cant find a drive gg")
    exit()
end

print("enter the key data")
local key = read()
print("working... (may be unbearably slow depending on server)")
local hash = sha256(key)
if fs.exists("/disk/key") then
    print("/disk/key already exists gg")
    exit()
end
if fs.exists("/key") then
    print("/key already exists gg")
    exit()
else
    local hashFile = fs.open("/key", "w")
    hashFile.write(hash)
    hashFile.close()

    local keyFile = fs.open("/disk/key", "w")
    keyFile.write(key)
    keyFile.close()
end

print("testing")

if validateKeyDisk() then
    print("key is good to go")
else
    print("something went wrong and the key and key hash don't line up")
end
