score = 0
saveData = {}
saveData.easyHS = 0
saveData.mediumHS = 0
saveData.hardHS = 0

--Functions for saving highscore, currently in progress.
saveHighscore = function (hs)
    local file = love.filesystem.newFile("assets/savedata.txt")
    file:open("w")
    file:write(hs)
    file:close()
end

loadHighscore = function ()
    local file = love.filesystem.newFile("assets/savedata.txt")
    file:open("r")
    saveData = file:read(saveData)
    file:close()
end

return score