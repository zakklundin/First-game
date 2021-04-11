local world = require('world')
local state = require('state')
local appleImage = love.graphics.newImage("assets/greenapple.png")

return function (x, y) --function for spawning seeds at x, y
    local greenApple = {}
    greenApple.body = love.physics.newBody(world, x, y, 'dynamic')
    greenApple.shape = love.physics.newCircleShape(35)
    greenApple.body:setLinearVelocity(0, 200 * vx)
    greenApple.fixture = love.physics.newFixture(greenApple.body, greenApple.shape, 1)
    greenApple.fixture:setUserData(greenApple)

    greenApple.draw = function (self)
        love.graphics.setColor(0,255,0)
        if not greenApple.fixture:isDestroyed() then
            local cx, cy = self.body:getWorldPoints(self.shape:getPoint())
            --love.graphics.circle('fill', cx, cy, self.shape:getRadius())  --(to see actual objects trajectory)
            love.graphics.draw(appleImage, cx - 35, cy - 40, 0, 0.022, 0.022)
        end
    end
    return greenApple
end
