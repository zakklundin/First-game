local world = require('world')

local x1 = 0
local y1 = -90
local x2 = 90
local y2 = -90
local x3 = 45
local y3 = 0

return function (x, y) -- returns a function so that i can spawn a redTriangle at (x, y) in main
    local redTriangle = {}
    redTriangle.body = love.physics.newBody(world, x, y, 'dynamic')
    redTriangle.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
    redTriangle.body:setLinearVelocity(0, 250 * vx) --speed is determined by 'vx' variable
    redTriangle.fixture = love.physics.newFixture(redTriangle.body, redTriangle.shape, 1)
    redTriangle.fixture:setUserData(redTriangle)

    redTriangle.draw = function (self)
        love.graphics.setColor(255, 0, 0)
        if not redTriangle.fixture:isDestroyed() then
            love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
        end
    end

    return redTriangle
end