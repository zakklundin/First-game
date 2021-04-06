love.load = function ()
    image = love.graphics.newImage("assets/Srek_bad_drawing.png")
    print("spelet har laddat klart")
    print('escape to pause, r to restart')
    love.graphics.setBackgroundColor(0, 0, 15)
    love.window.setMode(800, 600)
    ground = require('entities/ground')
    triangle = require('entities/triangle')
    world = require('world')
    state = require('state')
    basket = require('entities/trash_basket')
    score = require('entities/score')
    button = require('entities/button')
    buttons = {}
    if state.main_menu then
        table.insert(buttons, button(300, 100, "Start Game"))
        table.insert(buttons, button(300, 250, "Options"))
        table.insert(buttons, button(300, 400, "Exit Game"))
    end
    enemies = {} --'triangle(x, y)' is how you add a triangle
    math.randomseed(os.time())
    enemySpawner = function ()
        table.insert(enemies, triangle(love.math.random(-100, 600), -100))
    end
    spawnCooldown = 0
    vx = 1.25
    difficulty = "Medium"
    mousepressed = require('mousepressed')
    isMuted = false
    musicTrack = love.audio.newSource("assets/bensound-epic.mp3", "stream")
    musicTrack:setVolume(0.5)
    velocityChange = 0
end

love.draw = function()
    local font = love.graphics.newFont('assets/OpenSans-Bold.ttf', 20)
    love.graphics.setFont(font)
    love.graphics.setColor(1,1,1)
    if state.game_over then        
        love.graphics.print('GAME OVER', 280, 0, 0, 2, 2)
        love.graphics.print('Your score was: ' .. score, 260, 50, 0, 1.5, 1.5)
        love.graphics.print('Easy-Mode High Score:', 200, 90, 0, 1, 1)
        love.graphics.print('Medium-Mode High Score:', 200, 110, 0, 1, 1)
        love.graphics.print('Hard-Mode High Score:', 200, 130, 0, 1, 1)
        love.graphics.setColor(25, 0, 0)
    end
    love.graphics.draw(image, 300, 300)
    love.graphics.setColor(255, 255, 255)
    if state.paused then
        love.graphics.print('PAUSED', 320, 0, 0, 2, 2)
    end
    if state.options then
        love.graphics.print('Set difficulty:', 300, 200, 0, 1.5, 1.5) 
        love.graphics.print('OPTIONS', 320, 0, 0, 2, 2)
    end
    if state.main_menu then
        love.graphics.print('SREKS LAWN', (love.graphics.getWidth()/2 - 120), 0, 0, 2, 2)
    end
    if state.main_menu or state.options then
        love.graphics.print('Difficulty is set to ' .. difficulty, 225, 500, 0, 1, 1)
        if isMuted then
            love.graphics.print('Game is muted', 225, 520, 0, 1, 1)
        end
    end
    if not (state.main_menu or state.options or state.game_over) then
        love.graphics.print('Score: ' .. score, 0, 0, 0, 1.5, 1.5)
        love.graphics.print(vx, 0, 25, 0, 1, 1) --REMOVE LATER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        love.graphics.print('Keep trash off of Sreks lawn!', 250, 50)    
        love.graphics.polygon('fill', basket.body:getWorldPoints(basket.shape:getPoints()))
        love.graphics.setColor(255, 0, 0)
        for _, triangle in ipairs(enemies) do
            if triangle.draw then triangle:draw() end
        end
    end
    love.graphics.setColor(0, 15, 0)
    love.graphics.polygon('fill', ground.body:getWorldPoints(ground.shape:getPoints()))
    if state.main_menu or state.options or state.paused or state.game_over then --only display buttons in these states
        for _, button in ipairs(buttons) do
            if button.draw then button:draw() end
        end
    end
    
end

love.update = function (dt)
    if state.paused or state.game_over or state.main_menu or state.options then
        return --ends the love.update function if the states are true, which stops world:update (time) function
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
    spawnCooldown = spawnCooldown - dt
    while spawnCooldown <= 0 do
        spawnCooldown = spawnCooldown + 2
        enemySpawner()
    end
    while velocityChange >= 20 do --increases game by 20% speed every 20 points to increase difficulty over time
        velocityChange = 0
        vx = vx + 0.2*vx
    end
end

love.keypressed = function (pressed_key)
    if pressed_key == 'escape' and not (state.main_menu or state.options or state.game_over) then
        state.paused = not state.paused
        buttons = {} --makes sure no other buttons show when pausing game
        table.insert(buttons, button(300, 100, 'Resume'))
        table.insert(buttons, button(300, 250, 'Main Menu'))
        table.insert(buttons, button(300, 400, 'Exit Game'))
    elseif pressed_key == 'r' then
        love.event.quit('restart')
    end
end
