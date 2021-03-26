local world = require('world')
    x1 = 200
    y1 = -100
    x2 = 300
    y2 = -100
    x3 = 250
    y3 = 0

return function (x, y) -- returns a function so that i can spawn a triangle at (x, y) in main
    local triangle = {}
    triangle.body = love.physics.newBody(world, x, y, 'dynamic')
    triangle.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
    triangle.body:setMass(10000)
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