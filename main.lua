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
        table.insert(enemies, triangle(math.random(-100, 600), -100))
    end
    cooldown = 0
    vx = 1.2
    isMuted = false
    isMusicPlaying = false
    musicTrack = nil
    if isMusicPlaying == false and isMuted == false then
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
        love.graphics.print('GAME OVER', 300, 0, 0, 2, 2)
        love.graphics.print('Your score was: ' .. score, 250, 100, 0, 1.5, 1.5)
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
        love.graphics.print('Difficulty is set to ' .. vx, 225, 500, 0, 1, 1)
    end
    if not (state.main_menu or state.options or state.game_over) then
        love.graphics.print('Score: ' .. score, 0, 0, 0, 1.5, 1.5)
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
    cooldown = cooldown - dt
    while cooldown <= 0 do
        cooldown = cooldown + 1
        enemySpawner()
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

love.mousepressed = function (mouseX, mouseY, mouseButton)
    if mouseButton == 1 and state.main_menu then --1 means left mouse button
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then --checks if mouse cursor is within button limits
            state.main_menu = not state.main_menu
            buttons = {}
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            state.main_menu = not state.main_menu
            buttons = {} --clears buttons table
            state.options = not state.options 
            table.insert(buttons, button(300, 100, "Mute Sound"))
            table.insert(buttons, button(75, 250, "Easy")) table.insert(buttons, button(300, 250, "Medium")) table.insert(buttons, button(525, 250, "Hard"))
            table.insert(buttons, button(300, 400, "Back"))
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            love.event.quit()
        end
    end
    if mouseButton == 1 and state.options then --vänsterklick
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then --checks if mouse cursor is within button
            isMuted = not isMuted
        end
        if mouseX > 75 and mouseX < (75 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            vx = 1
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
           vx = 1.2
        end
        if mouseX > 525 and mouseX < (525 + 200) and mouseY > 250 and mouseY < (250 + 100) then
           vx = 1.5
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            state.options = not state.options
            buttons = {}
            state.main_menu = not state.main_menu
            table.insert(buttons, button(300, 100, "Start Game"))
            table.insert(buttons, button(300, 250, "Options"))
            table.insert(buttons, button(300, 400, "Exit Game"))
        end
    end
    if mouseButton == 1 and state.paused then
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 100 and mouseY < (100 + 100) then
            buttons = {}
            state.paused = not state.paused
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 250 and mouseY < (250 + 100) then
            love.event.quit('restart') --restarting the game leads to the main menu
        end
        if mouseX > 300 and mouseX < (300 + 200) and mouseY > 400 and mouseY < (400 + 100) then
            love.event.quit()
        end
    end
end