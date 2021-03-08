x = 100
y = 300
vx = 150

love.load = function ()
    image = love.graphics.newImage("images/Srek_bad_drawing.png")
    print("spelet har laddat klart")
    print('escape to close down, r to restart, p to pause game')
    love.graphics.setBackgroundColor(0, 0, 15) 
    love.window.setMode(800, 600)
    --circle = require('entities/circle')
    ground = require('entities/ground')
    triangle = require('entities/triangle')
    world = require('world')
    state = require('state')
    basket = require('entities/trash_basket')
end

love.draw = function()
    love.graphics.setColor(1,1,1)
    if state.game_over then
        love.graphics.setColor(25, 0, 0)
    end
    love.graphics.draw(image, 300, 300)
    love.graphics.setColor(255, 255, 255)
    if state.paused then
        love.graphics.print(
            'PAUSED, press p to resume',
            200,
            100,
            0,
            2,
            2
        )
    end
    if state.game_over then
        love.graphics.print(
            'GAME OVER, press r to restart',
            200,
            100,
            0,
            2,
            2
        )
    end
    love.graphics.polygon('fill', basket.body:getWorldPoints(basket.shape:getPoints()))
    love.graphics.print('keep trash off sreks lawn', 320, 50)
    love.graphics.setColor(255, 0, 0)
    if not triangle.fixture:isDestroyed() then
        love.graphics.polygon('fill', triangle.body:getWorldPoints(triangle.shape:getPoints()))
    end
    love.graphics.setColor(0, 15, 0)
    love.graphics.polygon('fill', ground.body:getWorldPoints(ground.shape:getPoints()))
end

love.update = function (dt)
    if state.paused or state.game_over then
        return
    end
    --print(dt)
    local self_x, self_y = basket.body:getPosition()
    if love.keyboard.isDown('right') and self_x < 800 then
        basket.body:setPosition(self_x + 10, self_y)
    elseif love.keyboard.isDown('left') and self_x > 0 then
        basket.body:setPosition(self_x - 10, self_y)
    end
    
world:update(dt)
end

love.keypressed = function (pressed_key)

    if pressed_key == 'escape' then
        love.event.quit()
    elseif pressed_key == 'r' then
        love.event.quit('restart')
    elseif pressed_key == 'p' then
        state.paused = not state.paused
    end

end
