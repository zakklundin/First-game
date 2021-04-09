local world = require('world')
local state = require('state')

return function (x, y) --function for spawning seeds at x, y
    local apple = {}
    apple.body = love.physics.newBody(world, x, y, 'dynamic')
    apple.shape = love.physics.newCircleShape(35)
    apple.body:setLinearVelocity(0, 200 * vx)
    apple.fixture = love.physics.newFixture(apple.body, apple.shape, 1)
    apple.fixture:setUserData(apple)

    apple.draw = function (self)
        love.graphics.setColor(0,255,0)
        if not apple.fixture:isDestroyed() then
            local cx, cy = self.body:getWorldPoints(self.shape:getPoint())
            love.graphics.circle('fill', cx, cy, self.shape:getRadius())
        end
    end
    return apple
end
