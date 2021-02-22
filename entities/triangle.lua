local world = require('world')

x1 = 200
y1 = 100
x2 = 300
y2 = 100
x3 = 250
y3 = 200

local triangle = {}
triangle.body = love.physics.newBody(world, 200, 100, 'dynamic')
triangle.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
triangle.body.setMass(triangle.body, 100)
triangle.fixture = love.physics.newFixture(triangle.body, triangle.shape, 1)
triangle.fixture:setUserData(triangle)



return triangle