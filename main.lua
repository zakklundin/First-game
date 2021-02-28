x = 100
y = 300
vx = 150

love.load = function ()
    image = love.graphics.newImage("Shrek_(character).png")
    print("spelet har laddat klart")
    print('escape to close down, r to restart, p to pause game')
    love.physics.setMeter(64)
    love.graphics.setBackgroundColor(0, 0, 15) 
    love.window.setMode(800, 600)
    circle = require('entities/circle')
    ground = require('entities/ground')
    triangle = require('entities/triangle')
    world = require('world')
    state = require('state')
end

love.draw = function()
    love.graphics.setColor(1,1,1)
    if state.game_over then
        love.graphics.setColor(50, 0, 0)
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
    love.graphics.circle('fill', circle.body:getX(), circle.body:getY(), circle.shape:getRadius())
    love.graphics.print('keep trash off sreks lawn', 320, 50)
    love.graphics.setColor(255, 0, 0)
    love.graphics.polygon('fill', triangle.body:getWorldPoints(triangle.shape:getPoints()))
    love.graphics.setColor(0, 15, 0)
    love.graphics.polygon('fill', ground.body:getWorldPoints(ground.shape:getPoints()))
end

--local paused = false

love.update = function (dt)
    if state.paused or state.game_over then
        return
    end

    --print(dt)
    --x = x + vx * dt

    if love.keyboard.isDown('up') then
        circle.body:applyForce(0, -100)
    elseif love.keyboard.isDown('down') then
        circle.body:applyForce(0, 100)
    elseif love.keyboard.isDown('right') then
        circle.body:applyForce(100, 0)
    elseif love.keyboard.isDown('left') then
        circle.body:applyForce(-100, 0)
    end
world:update(dt)
end

love.keypressed = function (pressed_key)
    if pressed_key == 'w' then
        y = y - 50
    elseif pressed_key == 's' then
        y = y + 50
    elseif pressed_key == 'a' then
        x = x - 50
    elseif pressed_key == 'd' then
        x = x + 50
    end

    if pressed_key == 'escape' then
        love.event.quit()
    elseif pressed_key == 'r' then
        love.event.quit('restart')
    elseif pressed_key == 'p' then
        state.paused = not state.paused
    end

    --if pressed_key == 'right' then
    --    circle.body:applyForce(400, 0)
    --elseif pressed_key == 'left' then
    --    circle.body:applyForce(-400, 0)
    --elseif pressed_key == 'down' then
    --    circle.body:applyForce(0, 400)
    --elseif pressed_key == 'up' then
    --    circle.body:applyForce(0, -400)
    --end
end
