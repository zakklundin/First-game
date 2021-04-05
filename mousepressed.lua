state = require('state')

love.mousepressed = function (mouseX, mouseY, mouseButton)
    if mouseButton == 1 and state.main_menu then --1 means left mouse button
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then --checks if mouse cursor is within button limits
            state.main_menu = not state.main_menu
            buttons = {}
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            state.main_menu = not state.main_menu
            buttons = {} --clears buttons table
            state.options = not state.options 
            table.insert(buttons, button(300, 100, "Mute Sound"))
            table.insert(buttons, button(75, 250, "Easy")) table.insert(buttons, button(300, 250, "Medium")) table.insert(buttons, button(525, 250, "Hard"))
            table.insert(buttons, button(300, 400, "Back"))
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            love.event.quit()
        end
    end
    if mouseButton == 1 and state.options then --vänsterklick
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then --checks if mouse cursor is within button
            isMuted = not isMuted
        end
        if mouseX > 75 and mouseX < (75 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            vx = 1
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
           vx = 1.2
        end
        if mouseX > 525 and mouseX < (525 + 200) and mouseY > 250 and mouseY < (250 + 100) then
           vx = 1.5
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            state.options = not state.options
            buttons = {}
            state.main_menu = not state.main_menu
            table.insert(buttons, button(300, 100, "Start Game"))
            table.insert(buttons, button(300, 250, "Options"))
            table.insert(buttons, button(300, 400, "Exit Game"))
        end
    end
    if mouseButton == 1 and state.paused then
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then
            buttons = {}
            state.paused = not state.paused
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            love.event.quit('restart') --restarting the game leads to the main menu
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            love.event.quit()
        end
    end
end