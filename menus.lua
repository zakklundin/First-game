local playerImage = love.graphics.newImage("assets/player_basket.png")
local trashImage = love.graphics.newImage("assets/trash_bag.png")
local appleImage = love.graphics.newImage("assets/greenapple.png")
local srekImage = love.graphics.newImage("assets/Srek_bad_drawing.png")
local menus = {} --Empty table to store draw function in

--Stores info on what to draw in certain menus
menus.draw = function ()

    if state.main_menu then
        love.graphics.print("SREKS LAWN", (love.graphics.getWidth()/2 - 120), 0, 0, 2, 2)
        love.graphics.setColor(1,1,1) --transparent so that Srek image is visable
        love.graphics.draw(srekImage, 20, 250)
    end

    if state.game_over then
        love.graphics.setColor(255,0,0)
        love.graphics.print('GAME OVER', 280, 0, 0, 2, 2)
        love.graphics.setColor(255,255,255)
        love.graphics.print("Your score was: " .. score, 260, 50, 0, 1.5, 1.5)
        love.graphics.print("Easy-Mode High-Score: " .. saveData.easyHS, 200, 90)
        love.graphics.print("Medium-Mode High-Score: " .. saveData.mediumHS, 200, 110)
        love.graphics.print("Hard-Mode High-Score: " .. saveData.hardHS, 200, 130)
        love.graphics.setColor(25, 0, 0)
        love.graphics.draw(srekImage, 20, 250)
    end

    if state.tutorial then
        love.graphics.setColor(255,255,255)
        love.graphics.print("TUTORIAL", 300, 0, 0, 2, 2)
        love.graphics.print("Press [R] to force restart the game.", 0, 70)
        love.graphics.print("Press [Esc] during gameplay to pause game.", 0, 90)
        love.graphics.print("Use right and left arrow keys to move basket:", 0, 120)
        love.graphics.draw(playerImage, 700, 110, 0, 0.2, 0.2)
        love.graphics.print("Your objective is to pick these falling trash bags up with the basket:", 0, 220)
        love.graphics.draw(trashImage, 700, 150, 0, 0.12, 0.12)
        love.graphics.print("Picking them up will earn you a point, but if they hit the ground it's game over.", 0, 240)
        love.graphics.print("On medium and hard difficulties, these apples will fall occasionally:", 0, 320)
        love.graphics.draw(appleImage, 700, 300, 0, 0.022, 0.022)
        love.graphics.print("Picking them up will lose you a point", 0, 340)
        love.graphics.print("but letting them hit the ground will earn you a point.", 0, 360)
        love.graphics.print("Game speed is faster on higher difficulties, and increases during gameplay.", 0, 380)
    end

    if state.options then
        love.graphics.print("Set difficulty:", 300, 200, 0, 1.5, 1.5)
        love.graphics.print("OPTIONS", 310, 0, 0, 2, 2)
    end

end

return menus