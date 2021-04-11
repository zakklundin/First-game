score = 0
saveData = {}
saveData.easyHS = tonumber(love.filesystem.read("assets/savedata.txt", saveData.easyHS), 10)
saveData.mediumHS = tonumber(love.filesystem.read("assets/savedata.txt", saveData.mediumHS), 10)
saveData.hardHS = tonumber(love.filesystem.read("assets/savedata.txt", saveData.hardHS), 10)
if saveData.easyHS == nil then
    saveData.easyHS = 0
elseif saveData.mediumHS == nil then
    saveData.mediumHS = 0
elseif saveData.hardHS == nil then
    saveData.hardHS = 0
end

--[[local file = love.filesystem.newFile("assets/savedata.txt")
file:open("r") --'r' stands for read
easyHS = tonumber(file:read(easyHS), 10) --base 10
mediumHS = tonumber(file:read(mediumHS), 10)
hardHS = tonumber(file:read(hardHS), 10)
file:close()]]
return score