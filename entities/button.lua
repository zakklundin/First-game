local world = require("world")

--Returns a function that is used to create a button on x, y in main, with 'str' as title
return function (x, y, str)
    local button = {}
    button.body = love.physics.newBody(world, x, y)
    button.shape = love.physics.newRectangleShape(200, 100)

    button.draw = function ()
        love.graphics.setColor(0, 30, 15)
        love.graphics.rectangle("fill", x, y, 200, 100)
        love.graphics.setColor(255,255,255)
        love.graphics.printf(str, x, y, 130, "center", 0, 1.5, 1.5)
    end
    return button
end
