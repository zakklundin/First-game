love.keypressed = function (pressed_key)
    if pressed_key == "escape" and not (state.main_menu or state.options or state.game_over) then
        state.paused = not state.paused
        buttons = {} --Makes sure no other buttons show when pausing game
        table.insert(buttons, button(300, 100, "Resume"))
        table.insert(buttons, button(300, 250, "Main Menu"))
        table.insert(buttons, button(300, 400, "Exit Game"))
    elseif pressed_key == "r" then
        love.event.quit("restart")
    end
end

love.mousepressed = function (mouseX, mouseY, mouseButton)

    if mouseButton == 1 and state.main_menu then --Mousebutton 1 is the left mouse button
        --Checks if mouse cursor is within button limits
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 60 and mouseY < (60 + 100) then
            state.main_menu = not state.main_menu
            buttons = {}
            if not isMuted then
                musicTrack:play()
            end
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 185 and mouseY < (185 + 100) then
            state.main_menu = not state.main_menu
            buttons = {}
            state.options = not state.options 
            table.insert(buttons, button(300, 100, "Mute Sound"))
            table.insert(buttons, button(75, 250, "Easy")) table.insert(buttons, button(300, 250, "Medium")) table.insert(buttons, button(525, 250, "Hard"))
            table.insert(buttons, button(300, 400, "Back"))
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 310 and mouseY < (310 + 100) then
            state.main_menu = not state.main_menu
            buttons = {}
            state.tutorial = not state.tutorial
            table.insert(buttons, button(300, 435, "Back"))
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 435 and mouseY < (435 + 100) then
            love.event.quit()
        end
    end

    if mouseButton == 1 and state.options then
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then
            isMuted = not isMuted
        end
        if mouseX > 75 and mouseX < (75 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            vx = 1.0
            difficulty = "Easy"
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
           vx = 1.25
           difficulty = "Medium"
        end
        if mouseX > 525 and mouseX < (525 + 200) and mouseY > 250 and mouseY < (250 + 100) then
           vx = 1.5
           difficulty = "Hard"
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            state.options = not state.options
            buttons = {}
            state.main_menu = not state.main_menu
            table.insert(buttons, button(300, 60, "Start Game"))
            table.insert(buttons, button(300, 185, "Options"))
            table.insert(buttons, button(300, 310, "Tutorial"))
            table.insert(buttons, button(300, 435, "Exit Game"))
        end
    end

    if mouseButton == 1 and state.paused then
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then
            buttons = {}
            state.paused = not state.paused
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            love.event.quit("restart") --Restarting the game leads to the main menu
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            love.event.quit()
        end
    end

    if mouseButton == 1 and state.game_over then
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 200 and mouseY < (200 + 100) then
            love.event.quit("restart")
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 350 and mouseY < (350 + 100) then
            love.event.quit()
        end
    end
    
    if mouseButton == 1 and state.tutorial then
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 435 and mouseY < (435 + 100) then
            state.tutorial = not state.tutorial
            buttons = {}
            state.main_menu = not state.main_menu
            table.insert(buttons, button(300, 60, "Start Game"))
            table.insert(buttons, button(300, 185, "Options"))
            table.insert(buttons, button(300, 310, "Tutorial"))
            table.insert(buttons, button(300, 435, "Exit Game"))
        end
    end
end
