# lift-controller

control a gantry shaft lift using a computer. was created on 1.21.1 with CC:Restitched and Create 6.

> [!CAUTION]
> lift-controller does not authenticate client requests. If this is an issue, look for a different solution or graft authentication into the server.

## start

download ./server/startup.lua to a computer at your gantry shaft and connect the shaft and the gearshift to the computer with redstone. put a modem or ender modem somewhere on the computer, and edit the CONFIG table at the top of the file according to your setup.

download ./client/startup.lua to any computer you want to control the lift with and edit the CONFIG table at the top of the file to work with your setup. in particular, edit the `FLOORWAIT` option to the amount of time in ticks for the server to actuate the lift for before stopping again to move between floors. according to the Create wiki, the speed of the gantry carriage is approximately $s=0.03846r$, where $s$ is the speed of the gantry carriage in blocks per second and $r$ is the speed of the gantry shaft in RPM. divide this by 20 to get the speed per tick and round to the nearest tenth to account for the grid snapping that happens when the contraption stops.

## usage

start the server up, and then start your client. the green button will actuate the lift by one floor, the red button will reverse the direction of the shaft and the blue button will toggle the actuation of the lift. do note this will most likely cause misalignment and if you really need an elevator you should probably use elevator pulleys instead.