x = 100
y = 300
vx = 150

x1 = 200
y1 = 100
x2 = 300
y2 = 100
x3 = 250
y3 = 200

love.load = function ()
    image = love.graphics.newImage("HSWH2x2.jpg")
    print("spelet har laddat klart")
    print('escape to close down, r to restart game')
end

love.draw = function ()
    love.graphics.draw(image, 500, 300)
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", x, y, 50)
    love.graphics.setColor(255, 0, 0)
    love.graphics.polygon("fill", x1, y1, x2, y2, x3, y3)
end

love.update = function (dt)
    --print(dt)
    --x = x + vx * dt
    x1 = x1 - 1
    x2 = x2 + 1
    y3 = y3 + 1
    y1 = y1 - 1
    y2 = y2 - 1
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
    end
    if pressed_key == 'r' then
        love.event.quit('restart')
    end
end