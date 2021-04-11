local world = require("world")
local basketImage = love.graphics.newImage("assets/player_basket.png")

local basket = {}
basket.body = love.physics.newBody(world, 250, 500, "static")
basket.body:setMass(0)
basket.shape = love.physics.newRectangleShape(100, 20)
basket.fixture = love.physics.newFixture(basket.body, basket.shape, 1)
basket.fixture:setUserData(basket)

basket.draw = function ()
    --Scale of image had to be lowered to 0.25:
    love.graphics.draw(basketImage, basket.body:getX() - 50, basket.body:getY() - 45, 0, 0.25, 0.25)
end

return basket