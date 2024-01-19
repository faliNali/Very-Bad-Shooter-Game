local anim8 = require('vendor/anim8')

local BulletHandler = {}
BulletHandler.__index = BulletHandler

function BulletHandler.new()
  local bh = {}
  setmetatable(bh, BulletHandler)
  
  bh.bullets = {}
  bh.roundRadius = {2, 3, 4}
  bh.pointRadius = {1.5, 2, 5}
  
  return bh
end


function BulletHandler:newCircleBullet(newX, newY, speed, angle, size, color, facePlayer)
  local bullet = {}
  
  bullet.isCBullet = true
  bullet.x, bullet.y = newX, newY
  if facePlayer then
    bullet.velocity = bv(angle, newX, newY)
  else
    bullet.velocity = bv(angle)
  end
  bullet.speed = speed
-- 1-3
  bullet.size = size
  bullet.radius = 0
  if bullet.size == 1 then
    bullet.radius = 2
  elseif bullet.size == 2 then
    bullet.radius = 3
  elseif bullet.size == 3 then
    bullet.radius = 4
  end
-- 1-7
  bullet.color = color
  
  table.insert(self.bullets, bullet)
end


function BulletHandler:newPointBullet(newX, newY, speed, angle, color, facePlayer)
  local bullet = {}
  
  bullet.isPBullet = true
  bullet.x, bullet.y = newX, newY
  if facePlayer then
    bullet.velocity = bv(angle, newX, newY)
  else
    bullet.velocity = bv(angle)
  end
  bullet.rotation = math.rad(angle) + math.atan2(newY - game.player.y, newX - game.player.x) + math.pi / 2
  bullet.radius = 2.5
  bullet.speed = speed
-- 1-3
  bullet.size = size
-- 1-7
  bullet.color = color
  
  table.insert(self.bullets, bullet)
end


function BulletHandler:update(dt)
  for i, v in ipairs(self.bullets) do
    v.x = v.x + v.velocity.x * v.speed * dt
    v.y = v.y + v.velocity.y * v.speed * dt
    if v.x < PLAYAREA.ORIGIN.X-5 or v.x > PLAYAREA.END.X+5 or v.y < PLAYAREA.ORIGIN.Y-5 or v.y > PLAYAREA.END.Y+5 then
      table.remove(self.bullets, i)
    end
  end
end


function BulletHandler:draw()
  for i, v in ipairs(self.bullets) do
    if v.isCBullet then
      love.graphics.draw(sprites.bullets, game.grids.bulletRound[v.size]('1-7', 1)[v.color], v.x, v.y, 0, 1, 1, v.radius, v.radius)
    end
    if v.isPBullet then
      love.graphics.draw(sprites.bullets, game.grids.bulletPoint('1-7', 1)[v.color], v.x, v.y, v.rotation, 1, 1, v.radius, v.radius)
    end
  end
end

return BulletHandler