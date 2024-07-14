# computercraft-archive

### list of files and what they do:

# [amethyst-miner.lua](amethyst-miner.lua) 
i made this to automate amethyst collection for my estrogen farm, it's not the greatest looking thing ever nor is it very fast but it works.

by default, the program assumes the configuration shown in the diagram. this can be changed by editing the `startMining()` function. for different configurations you may also need to add another direction to the `rowNav()` function and/or add additional mining functions.

![diagram from a top down view showing how to build the default configuration of the farm](assets/amethyst-miner/diagram.png)

this program requires an advanced mining turtle (normal mining turtle might work, haven't tested) and an amethyst cluster for comparing the blocks and detecting which ones to mine

improvements that could be made:
- ~~replace a ton of the `startMining()` function with simpler and faster `rowNav()` commands, like just doing a ring around the top of every cluster to get the sides and the top~~
- replace `turtle.compare*()` functions with `turtle.inspect()` to remove the dependency on the amethyst cluster in the selected slot
- ~~detect if there's already an amethyst cluster in the inventory on startup~~
