local anim8 = require 'vendor/anim8'

local Ghost = {}
Ghost.__index = Ghost

function Ghost.new(newX, newY, bulletSpeed, bulletSize, bulletColor, bulletPattern)
  local ghost = {}
  setmetatable(ghost, Ghost)
  
  ghost.isGhost = true
  ghost.x, ghost.y = newX, newY
  ghost.radius = 6
  ghost.maxTimer = 2
  ghost.timer = ghost.maxTimer
  ghost.bulletSpeed = bulletSpeed or 40
  ghost.bulletSize = bulletSize or 2
  ghost.bulletColor = bulletColor or 5
  ghost.bulletPattern = bulletPattern or {150, 165, 180, 195, 210}
  ghost.default_anim = anim8.newAnimation(game.grids.enemies.ghost('1-4', 1), 0.15)
  ghost.anim = ghost.default_anim
  ghost.health = 10
  
  return ghost
end


function Ghost:update(dt)
  self.anim:update(dt)
  
  self.timer = self.timer - dt
  if self.timer <= 0 then
    for i, v in ipairs(self.bulletPattern) do
      game.bh:newCircleBullet(self.x, self.y, self.bulletSpeed, v, self.bulletSize, self.bulletColor, true)
    end
    self.timer = self.timer + self.maxTimer
  end
end


function Ghost:draw()
  self.anim:draw(sprites.enemies.ghost, self.x, self.y, 0, 1, 1, 8, 8)
end


return Ghost