score = 0
saveData = {}
saveData.easyHS = 0
saveData.mediumHS = 0
saveData.hardHS = 0
local file = love.filesystem.newFile("assets/savedata.txt")
file:open("r") --'r' stands for read
easyHS = tonumber(file:read(easyHS), 10) --base 10
mediumHS = tonumber(file:read(mediumHS), 10)
hardHS = tonumber(file:read(hardHS), 10)
file:close()
return score