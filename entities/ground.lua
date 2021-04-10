local world = require('world')
local state = require('state')

local ground = {}
ground.body = love.physics.newBody(world, 400, 600)
ground.shape = love.physics.newRectangleShape(800, 100)
ground.fixture = love.physics.newFixture(ground.body, ground.shape)
ground.fixture:setUserData(ground)

--ground.begin_contact = function (self)
--end

return ground