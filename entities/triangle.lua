local world = require('world')

score = 0
    x1 = 200
    y1 = -100
    x2 = 300
    y2 = -100
    x3 = 250
    y3 = 0

return function (x, y)
    local triangle = {}
    triangle.body = love.physics.newBody(world, x, y, 'dynamic')
    triangle.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
    triangle.body:setMass(10000)
    triangle.fixture = love.physics.newFixture(triangle.body, triangle.shape, 1)
    triangle.fixture:setUserData(triangle)
    
    triangle.begin_contact = function (self)
        triangle.fixture:destroy()
        score = score + 1
    end

    triangle.draw = function (self)
        love.graphics.setColor(255, 0, 0)
        love.graphics.polygon('fill', self.body:getWorldPoints(self.shape:getPoints()))
    end

    return triangle
end