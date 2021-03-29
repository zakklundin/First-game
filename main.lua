love.load = function ()
    image = love.graphics.newImage("assets/Srek_bad_drawing.png")
    print("spelet har laddat klart")
    print('escape to close down, r to restart, p to pause game')
    love.graphics.setBackgroundColor(0, 0, 15) 
    love.window.setMode(800, 600)
    ground = require('entities/ground')
    triangle = require('entities/triangle')
    world = require('world')
    state = require('state')
    basket = require('entities/trash_basket')
    enemies = {
        --triangle(100, 0) is how you add a triangle
    }
    math.randomseed(os.time())
    enemySpawner = function ()
        table.insert(enemies, triangle(math.random(-100, 650), -100))
    end
    cooldown = 0
    difficulty = 2
    vx = 1.2
    if difficulty == 1 then
        vx = 1
    elseif difficulty == 3 then
        vx = 1.4
    else 
        vx = 1.2
    end

    isMusicPlaying = false
    musicTrack = nil
    if isMusicPlaying == false then
        if musicTrack == nil then
            musicTrack = love.audio.newSource("assets/bensound-epic.mp3", "stream")
            musicTrack:setVolume(0.5)
        end
        if state.main_menu then
            musicTrack:pause()
        end
        musicTrack:play()
        isMusicPlaying = true
    end
end

love.draw = function()
    local font = love.graphics.newFont('assets/OpenSans-Bold.ttf', 20)
    love.graphics.setFont(font)
    love.graphics.setColor(1,1,1)
    if state.game_over then
        love.graphics.setColor(25, 0, 0)
    end
    love.graphics.draw(image, 300, 300)
    love.graphics.setColor(255, 255, 255)
    if state.paused then
        love.graphics.print('PAUSED, press p to resume', 200, 100, 0, 2, 2)
    end
    if state.main_menu then
        love.graphics.print('SREKS LAWN', (love.graphics.getWidth()/2 - 100), 0, 0, 2, 2)
        love.graphics.print('Press any key to start', 200, 100, 0, 1, 1)
        if difficulty == 2 then
            love.graphics.print('Difficulty is set to medium', (love.graphics.getWidth()/2 - font:getWidth("Difficulty is set to medium")/2), 250, 0, 1, 1)
        end
    end
    if state.game_over then
        love.graphics.print('GAME OVER, press r to restart', 100, 100, 0, 2, 2)
    end
    if not state.main_menu then
        love.graphics.print('Score: ' .. score, 0, 0, 0, 1.5, 1.5)
        love.graphics.print('Keep trash off of Sreks lawn!', 250, 50)    
        love.graphics.polygon('fill', basket.body:getWorldPoints(basket.shape:getPoints()))
    end
    love.graphics.setColor(255, 0, 0)
    for _, triangle in ipairs(enemies) do
        if triangle.draw then triangle:draw() end
    end
    love.graphics.setColor(0, 15, 0)
    love.graphics.polygon('fill', ground.body:getWorldPoints(ground.shape:getPoints()))
end

love.update = function (dt)
    if state.paused or state.game_over or state.main_menu then
        return --ends the function if the states are true, which stops world:update function
    end
    --print(dt)
    local self_x, self_y = basket.body:getPosition()
    if love.keyboard.isDown('right') and self_x < 800 then
        basket.body:setPosition(self_x + 15, self_y)
    elseif love.keyboard.isDown('left') and self_x > 0 then
        basket.body:setPosition(self_x - 15, self_y)
    end
    
    dt = dt * vx
    world:update(dt)

    cooldown = cooldown - dt
    while cooldown <= 0 do
        cooldown = cooldown + 1
        enemySpawner()
    end
end

love.keypressed = function (pressed_key)
    if pressed_key == 'escape' then
        love.event.quit()
    elseif pressed_key == 'r' then
        love.event.quit('restart')
    elseif pressed_key == 'p' and state.main_menu == false and state.game_over == false then
        state.paused = not state.paused
    elseif pressed_key and state.main_menu then --alla tangenter ska starta spelet, men ska bara gå när det är i main menu
        state.main_menu = not state.main_menu
    end
end
