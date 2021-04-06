local world = require('world')
local x1 = 200
local y1 = -100
local x2 = 300
local y2 = -100
local x3 = 250
local y3 = 0

return function (x, y) -- returns a function so that i can spawn a triangle at (x, y) in main
    local triangle = {}
    triangle.body = love.physics.newBody(world, x, y, 'dynamic')
    triangle.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
    triangle.body:setLinearVelocity(0, 250 * vx)
    --triangle.body:setMass(5)
    triangle.fixture = love.physics.newFixture(triangle.body, triangle.shape, 1)
    triangle.fixture:setUserData(triangle)
    triangle.begin_contact = function (self)
        triangle.fixture:destroy()
    end

    triangle.draw = function (self)
        love.graphics.setColor(255, 0, 0)
        if  not triangle.fixture:isDestroyed() then
            love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
        end
    end

    return triangle
end