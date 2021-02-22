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
end

love.draw = function()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(image, 300, 300)
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill', circle.body:getX(circle.body), circle.body:getY(circle.body), circle.shape:getRadius())
    love.graphics.print('keep trash off sreks lawn', 320, 50)
    love.graphics.setColor(255, 0, 0)
    love.graphics.polygon('fill', triangle.body:getWorldPoints(triangle.shape:getPoints()))
    love.graphics.setColor(0, 15, 0)
    love.graphics.polygon('fill', ground.body:getWorldPoints(ground.shape:getPoints()))
end

local paused = false

love.update = function (dt)
    if not paused then
        world:update(dt)
    end
    --print(dt)
    --x = x + vx * dt
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
        paused = not paused
    end

    if pressed_key == 'right' then
        circle.body:applyForce(400, 0)
    elseif pressed_key == 'left' then
        circle.body:applyForce(-400, 0)
    elseif pressed_key == 'down' then
        circle.body:applyForce(0, 400)
    elseif pressed_key == 'up' then
        circle.body:applyForce(0, -400)
    end
end

--objects.begin_contact = function (self)
--    love.event.quit()
--end