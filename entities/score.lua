score = 0
maxScore = 0

saveMaxScore = function ()
   local data = {}
   data.maxScore = score
   love.filsystem.write("savegame.txt", (data))
end

return score