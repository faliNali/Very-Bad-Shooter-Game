local anim8 = require 'vendor/anim8'

local Player = {}
Player.__index = Player

function Player.new(newX, newY)
  local player = {}
  setmetatable(player, Player)
  
  player.isPlayer = true
  player.x, player.y = newX, newY
  player.radius = 0.8
  player.speed = 80
  player.lives = 3
  player.default_anim = anim8.newAnimation(game.grids.player('1-2', 1), 0.08)
  player.anim = player.default_anim
  player.scale = {x=1, y=1}
  player.rotation = 0
  player.spriteHitDuration = 0
  player.hitDuration = 0
  
  return player
end


function Player:update(dt)
  self.anim:update(dt)
  
  if self.spriteHitDuration > 0 then
    self.spriteHitDuration = self.spriteHitDuration - dt
  end
  if self.hitDuration > 0 then
    self.hitDuration = self.hitDuration - dt
  end
  
  local velocity = {x = 0, y = 0}
  if love.keyboard.isDown('left') then
    velocity.x = velocity.x - 1
  end
  if love.keyboard.isDown('right') then
    velocity.x = velocity.x + 1
  end
  if love.keyboard.isDown('up') then
    velocity.y = velocity.y - 1
  end
  if love.keyboard.isDown('down') then
    velocity.y = velocity.y + 1
  end
  
  velocity.x, velocity.y = normalize(velocity.x, velocity.y)
  self.x = self.x + velocity.x * self.speed * dt
  self.y = self.y + velocity.y * self.speed * dt
  
  local limit = 2
  if self.x < PLAYAREA.ORIGIN.X + limit then
    self.x = PLAYAREA.ORIGIN.X + limit
  end
  if self.x > PLAYAREA.END.X - limit then
    self.x = PLAYAREA.END.X - limit
  end
  if self.y < PLAYAREA.ORIGIN.Y + limit then
    self.y = PLAYAREA.ORIGIN.Y + limit
  end
  if self.y > PLAYAREA.END.Y - limit then
    self.y = PLAYAREA.END.Y - limit
  end
  
  for i, v in ipairs(game.bh.bullets) do
    if isCollided(self.x, self.y, self.radius, v.x, v.y, v.radius) and self.hitDuration <= 0 then
      self:hit()
      table.remove(game.bh.bullets, i)
    end
  end
end

function Player:draw()
  if self.hitDuration > 0 then
    love.graphics.setColor(1, 1, 1, 0.75)
  end
  if self.spriteHitDuration > 0 then
    love.graphics.draw(sprites.player.default, game.quads.playerHit, self.x, self.y, self.rotation, self.scale.x, self.scale.y, 8, 8)
  else
    self.anim:draw(sprites.player.default, self.x, self.y, self.rotation, self.scale.x, self.scale.y, 8, 8)
  end
  love.graphics.setColor(0.8, 0.9, 1)
  love.graphics.circle('fill', self.x, self.y, self.radius)
  love.graphics.setColor(0.95, 0.95, 1)
  love.graphics.circle('fill', self.x, self.y, self.radius * 0.75)
  love.graphics.setColor(1, 1, 1)
end


function Player:hit()
  self.spriteHitDuration = self.spriteHitDuration + 0.1
  self.hitDuration = self.hitDuration + 0.8
  self.lives = self.lives - 1
end

return Player