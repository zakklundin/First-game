local appleImage = love.graphics.newImage("assets/greenapple.png")

--Returns a function that is used to spawn apples at coordinates x, y in main
return function (x, y)
    local greenApple = {}
    greenApple.body = love.physics.newBody(world, x, y, "dynamic")
    greenApple.shape = love.physics.newCircleShape(35)
    greenApple.body:setLinearVelocity(0, 200 * vx)
    greenApple.fixture = love.physics.newFixture(greenApple.body, greenApple.shape, 1)
    greenApple.fixture:setUserData(greenApple)

    greenApple.draw = function (self)
        love.graphics.setColor(0,255,0)
        if not greenApple.fixture:isDestroyed() then
            local cx, cy = self.body:getWorldPoints(self.shape:getPoint()) --coordinates for the body
            love.graphics.draw(appleImage, cx - 35, cy - 40, 0, 0.022, 0.022) --scale is set to 0.022 because image is too large
        end
    end

    return greenApple
end
