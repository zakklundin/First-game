saveHighscore = function (hs)
    love.filesystem.write("savedata.sav", hs)
end

loadHighscore = function ()
    local highScore = love.filesystem.read("savedata.sav")

    --First time opening game highscore will be nil, needs to be a number
    if highScore == nil then
        highScore = 0
    end

    return highScore
end