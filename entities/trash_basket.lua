local world = require('world')
score = 0

local basket = {}
basket.body  = love.physics.newBody(world, 250, 500, 'static')
basket.body:setMass(0)
basket.shape = love.physics.newRectangleShape(100, 20)
basket.fixture = love.physics.newFixture(basket.body, basket.shape, 1)
basket.fixture:setUserData(basket)

basket.begin_contact = function ()
    score = score + 1
end

return basket