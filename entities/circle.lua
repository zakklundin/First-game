local world = require('world')

local circle = {}
circle.body = love.physics.newBody(world, 300, 300, 'dynamic')
circle.body.setMass(circle.body, 15)
circle.shape = love.physics.newCircleShape(20)
circle.fixture = love.physics.newFixture(circle.body, circle.shape, 1)
circle.fixture:setUserData(circle)

return circle