love.load = function ()
    image = love.graphics.newImage("assets/Srek_bad_drawing.png")
    print("spelet har laddat klart")
    print('escape to pause, r to restart')
    love.graphics.setBackgroundColor(0, 0, 15)
    love.window.setMode(800, 600)
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
    obstacles = {} --'triangle(x, y)' is how you add a triangle
    apples = {}
    math.randomseed(os.time())
    enemySpawner = function ()
        table.insert(obstacles, triangle(love.math.random(-50, 550), -100))
    end
    circleSpawner = function ()
        obstacles = {} --empties the obstacles table, no triangles fall at the same time as apples
        table.insert(apples, apple(love.math.random(-50, 550), -100))
    end
    spawnCooldown = 0
    circleCooldown = 10
    vx = 1.25
    difficulty = "Medium"
    isMuted = false
    musicTrack = love.audio.newSource("assets/bensound-epic.mp3", "stream")
    musicTrack:setVolume(0.4)
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
        for _, triangle in ipairs(obstacles) do
            if triangle.draw then triangle:draw() end
        end
        for _, apple in ipairs(apples) do
            if apple.draw then apple:draw() end
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
    circleCooldown = circleCooldown - dt
    while spawnCooldown <= 0 do
        spawnCooldown = spawnCooldown + 2
        enemySpawner()
    end
    if difficulty == "Medium" or difficulty == "Hard" then --No apples on easy mode!
        while circleCooldown <= 0 do
            circleCooldown = circleCooldown + 10
            circleSpawner()
        end
    end
    while velocityChange >= 5 do --increases game by 5% speed every 5 points to increase difficulty over time
        velocityChange = 0
        vx = vx + 0.05*vx
    end
    for i, triangle in ipairs(obstacles) do
        if checkCollision(triangle.fixture, ground.fixture) then
            state.game_over = true
            table.insert(buttons, button(300, 200, 'Main Menu'))
            table.insert(buttons, button(300, 350, 'Exit Game'))
        end
        if checkCollision(triangle.fixture, basket.fixture) then
            table.remove(obstacles, i) --removes colliding triangle from obstacles table
            triangle.fixture:destroy() --destroys the colliding triangles fixture
            score = score + 1
            velocityChange = velocityChange + 1
        end
    end
    for i, apple in ipairs(apples) do
        if checkCollision(apple.fixture, ground.fixture) then
            table.remove(apples, i)
            apple.fixture:destroy()
            score = score + 1
            velocityChange = velocityChange + 1
        end
        if checkCollision(apple.fixture, basket.fixture) then --lose a point when you pick apple up
            table.remove(apples, i)
            apple.fixture:destroy()
            score = score - 1
        end
    end
    
end
