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
    image = love.graphics.newImage("Shrek_(character).png")
    print("spelet har laddat klart")
    print('escape to close down, r to restart game')
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9,82*64, true)

    objects = {}

    objects.ground = {}
    objects.ground.body = love.physics.newBody(world, 400, 600)
    objects.ground.shape = love.physics.newRectangleShape(800, 100)
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)

    objects.circle = {}
    objects.circle.body = love.physics.newBody(world, 300, 300, 'dynamic')
    objects.circle.body: setMass(15)
    objects.circle.shape = love.physics.newCircleShape(20)
    objects.circle.fixture = love.physics.newFixture(objects.circle.body, objects.circle.shape, 1)

    objects.triangle = {}
    objects.triangle.body = love.physics.newBody(world, 200, 200, 'dynamic')
    objects.triangle.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
    objects.triangle.body:setMass(30)
    objects.triangle.fixture = love.physics.newFixture(objects.triangle.body, objects.triangle.shape, 1)

    love.graphics.setBackgroundColor(0, 0, 15) 
    love.window.setMode(800, 600)
end


love.draw = function ()
    love.graphics.draw(image, 300, 300)
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill', objects.circle.body:getX(), objects.circle.body:getY(), objects.circle.shape:getRadius())
    love.graphics.circle("fill", x, y, 20)
    love.graphics.setColor(255, 0, 0)
    --love.graphics.polygon("fill", x1, y1, x2, y2, x3, y3)
    love.graphics.polygon('fill', objects.triangle.body:getWorldPoints(objects.triangle.shape:getPoints()))

    love.graphics.setColor(0, 15, 0)
    love.graphics.polygon('fill', objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))
end

love.update = function (dt)
    world:update(dt)
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

    if pressed_key == 'right' then
        objects.circle.body:applyForce(400, 0)
    elseif pressed_key == 'left' then
        objects.circle.body:applyForce(-400, 0)
    elseif pressed_key == 'down' then
        objects.circle.body:applyForce(0, 400)
    elseif pressed_key == 'up' then
        objects.circle.body:applyForce(0, -400)
    end

    if pressed_key == 'r' then
        love.event.quit('restart')
    end
end
