local world = require("world")

local ground = {}
ground.body = love.physics.newBody(world, 400, 600)
ground.body:setMass(0)
ground.shape = love.physics.newRectangleShape(800, 100)
ground.fixture = love.physics.newFixture(ground.body, ground.shape)
ground.fixture:setUserData(ground)

return ground