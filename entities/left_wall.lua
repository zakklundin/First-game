local world = require('world')

local wall = {}
wall.body = love.physics.newBody(world, 1, 0, 'static')
wall.shape = love.physics.newRectangleShape(1, 600)
wall.fixture = love.physics.newFixture(wall.body, wall.shape, 1)
wall.fixture:setUserData(wall)