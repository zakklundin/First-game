local world = love.physics.newWorld(0, 5, true) --low gravity, setLinearVelocity is mainly used for falling objects instead
love.physics.setMeter(64)

--checks if the distance between two fixtures is less than "1", and returns a boolean
checkCollision = function (A, B)
  if love.physics.getDistance(A, B) <= 1 then
    return true
  end
end

return world