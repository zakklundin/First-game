spawnCooldown = 0
circleCooldown = 10
vx = 1.25
difficulty = "Medium"
isMuted = false
obstacles = {} --'triangle(x, y)' is how you add a triangle
apples = {}
velocityChange = 0
local file = love.filesystem.newFile("assets/savedata.txt")

love.load = function ()
    image = love.graphics.newImage("assets/Srek_bad_drawing.png")
    print("spelet har laddat klart")
    print('escape to pause, r to restart')
    love.graphics.setBackgroundColor(0, 0, 15)
    input = require('input')
    ground = require('entities/ground')
    triangle = require('entities/triangle')
    apple = require('entities/greenApple')
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
    math.randomseed(os.time())
    enemySpawner = function ()
        table.insert(obstacles, triangle(love.math.random(-50, 650), -100))
    end
    appleSpawner = function ()
        obstacles = {} --empties the obstacles table, no triangles fall at the same time as apples
        table.insert(apples, apple(love.math.random(-50, 650), -100))
    end
    musicTrack = love.audio.newSource("assets/bensound-epic.mp3", "stream")
    musicTrack:setVolume(0.4)
end

love.draw = function()
    local font = love.graphics.newFont('assets/OpenSans-Bold.ttf', 20)
    love.graphics.setFont(font)
    if state.game_over then
        love.graphics.setColor(255,0,0)
        love.graphics.print('GAME OVER', 280, 0, 0, 2, 2)
        love.graphics.setColor(255,255,255)
        love.graphics.print('Your score was: ' .. score, 260, 50, 0, 1.5, 1.5)
        love.graphics.print('Easy-Mode High-Score: ' .. saveData.easyHS, 200, 90, 0, 1, 1)
        love.graphics.print('Medium-Mode High-Score: ' .. saveData.mediumHS, 200, 110, 0, 1, 1)
        love.graphics.print('Hard-Mode High-Score: ' .. saveData.hardHS, 200, 130, 0, 1, 1)
        love.graphics.setColor(25, 0, 0)
        love.graphics.draw(image, 20, 250)
    end
    love.graphics.setColor(255, 255, 255)
    if state.paused then
        love.graphics.print('PAUSED', 320, 0, 0, 2, 2)
    end
    if state.options then
        love.graphics.print('Set difficulty:', 300, 200, 0, 1.5, 1.5) 
        love.graphics.print('OPTIONS', 310, 0, 0, 2, 2)
    end
    if state.main_menu then
        love.graphics.print('SREKS LAWN', (love.graphics.getWidth()/2 - 120), 0, 0, 2, 2)
        love.graphics.setColor(1,1,1) --transparent so that Srek image is visable
        love.graphics.draw(image, 20, 250)
    end
    if state.main_menu or state.options then
        love.graphics.print('Difficulty is set to ' .. difficulty, 270, 500, 0, 1, 1)
        if isMuted then
            love.graphics.print('Game is muted', 320, 520, 0, 1, 1)
        end
    end
    if not (state.main_menu or state.options or state.game_over) then
        love.graphics.print('Score: ' .. score, 0, 0, 0, 1.5, 1.5)
        love.graphics.print(vx, 0, 25, 0, 1, 1) --REMOVE LATER!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        love.graphics.print('Protect Sreks lawn!', 300, 50)    
        love.graphics.polygon('fill', basket.body:getWorldPoints(basket.shape:getPoints()))
        love.graphics.setColor(255, 0, 0)
        for _, redTriangle in ipairs(obstacles) do --draw all triangles in obstacles table
            if redTriangle.draw then redTriangle:draw() end
        end
        for _, greenApple in ipairs(apples) do --draw all apples in apples table
            if greenApple.draw then greenApple:draw() end
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
    local self_x, self_y = basket.body:getPosition()
    if love.keyboard.isDown('right') and self_x < 800 then
        basket.body:setPosition(self_x + 10*vx, self_y)
    elseif love.keyboard.isDown('left') and self_x > 0 then
        basket.body:setPosition(self_x - 10*vx, self_y)
    end
    dt = dt * vx
    world:update(dt)
    spawnCooldown = spawnCooldown - dt
    circleCooldown = circleCooldown - dt
    while spawnCooldown <= 0 do
        spawnCooldown = spawnCooldown + 2
        enemySpawner()
    end
    if difficulty == "Medium" or difficulty == "Hard" then --No apples on easy mode!
        while circleCooldown <= 0 do
            circleCooldown = circleCooldown + 10
            appleSpawner()
        end
    end
    while velocityChange >= 5 do --increases game by 5% speed every 5 points to increase difficulty over time
        velocityChange = 0
        vx = vx + 0.05*vx
    end
    for i, redTriangle in ipairs(obstacles) do
        if checkCollision(redTriangle.fixture, ground.fixture) then
            state.game_over = true
            table.insert(buttons, button(300, 200, 'Main Menu'))
            table.insert(buttons, button(300, 350, 'Exit Game'))
            
            if (score > saveData.easyHS) and difficulty == 'Easy' then
                saveData.easyHS = score
                file:open("w")
                file:write(saveData.easyHS)
                file:close()
             elseif (score > saveData.mediumHS) and (difficulty == 'Medium') and state.game_over then
                saveData.mediumHS = score
                file:open("w")
                file:write(saveData.mediumHS)
                file:close()
             elseif score > saveData.hardHS and difficulty == 'Hard' and state.game_over then
                saveData.hardHS = score
                file:open("w")
                file:write(saveData.hardHS)
                file:close()
             end
        end
        if checkCollision(redTriangle.fixture, basket.fixture) then
            table.remove(obstacles, i) --removes colliding triangle from obstacles table
            redTriangle.body:destroy() --destroys the colliding triangles fixture
            score = score + 1
            velocityChange = velocityChange + 1
        end
    end
    for i, greenApple in ipairs(apples) do
        if checkCollision(greenApple.fixture, ground.fixture) then -- gain a point when apple falls on ground
            table.remove(apples, i)
            greenApple.body:setPosition(-200, 600) --temporary solution to a bug, not sure if effective.
            score = score + 1
            velocityChange = velocityChange + 1
        end
        if checkCollision(greenApple.fixture, basket.fixture) then --lose a point when you pick apple up
            table.remove(apples, i)
            greenApple.body:destroy()
            score = score - 1
        end
    end
    
end
