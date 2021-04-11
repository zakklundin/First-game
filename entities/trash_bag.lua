local trashImage = love.graphics.newImage("assets/trash_bag.png")
local x1 = 0
local y1 = 0
local x2 = 90
local y2 = -0
local x3 = 45
local y3 = -90

--Returns a function that is used to spawn a trashBag at (x, y) coordinates in main
return function (x, y)
    local trashBag = {}
    trashBag.body = love.physics.newBody(world, x, y, 'kinematic') --Sinematic objects are not affected by gravity
    trashBag.shape = love.physics.newPolygonShape(x1, y1, x2, y2, x3, y3)
    trashBag.body:setLinearVelocity(0, 250 * vx) --Speed is determined by 'vx' variable
    trashBag.fixture = love.physics.newFixture(trashBag.body, trashBag.shape, 1)
    trashBag.fixture:setUserData(trashBag)

    trashBag.draw = function (self)
        love.graphics.setColor(255, 0, 0)
        if not trashBag.fixture:isDestroyed() then
            love.graphics.draw(trashImage, trashBag.body:getX() - 7, trashBag.body:getY() -95, 0, 0.12, 0.12)
        end
    end

    return trashBag
end