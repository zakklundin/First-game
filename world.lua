world = love.physics.newWorld(0, 5, true) --low gravity, setLinearVelocity is used for falling objects instead
love.physics.setMeter(64)

checkCollision = function (A, B) --A is object that falls
  if love.physics.getDistance(A, B) <= 1 then
    return true
  end
end

return world