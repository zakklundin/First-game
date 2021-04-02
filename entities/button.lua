local world = require('world')
local state = require('state')

return function (x, y, str)
    local button = {}
    button.body = love.physics.newBody(world, x, y)
    button.shape = love.physics.newRectangleShape(200, 100)

    button.draw = function ()
        love.graphics.setColor(0, 30, 15)
        love.graphics.rectangle('fill', x, y, 200, 100)
        love.graphics.setColor(255,255,255)
        love.graphics.print(str, x, y, 0, 1.5, 1.5)
    end
--[[
    love.mousepressed = function (mouseX, mouseY, mouseButton)
        if mouseButton == 1 and state.main_menu and button.number == 1 then --vänsterklick
            if mouseX > x and mouseX < (x + 200) and mouseY > y and mouseY < (y + 100) then --checks if mouse cursor is within button
                state.main_menu = not state.main_menu
            end
        end
        if mouseButton == 1 and state.main_menu and button.number == 2 then
            if mouseX > x and mouseX < (x + 200) and mouseY > y and mouseY < (y + 100) then
                state.options = not state.options
            end
        end
        if mouseButton == 1 and state.main_menu and button.number == 3 then
            if mouseX > x and mouseX < (x + 200) and mouseY > y and mouseY < (y + 100) then
                love.event.quit()
            end
        end
    end
--]]
    return button
end
