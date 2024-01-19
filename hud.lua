local Hud = {}
Hud.__index = Hud

function Hud.new()
  local hud = {}
  setmetatable(hud, Hud)
  
  hud.shooterPowerPos = {x = 210, y = 80}
  hud.livesPos = {x = 210, y = 120}
  
  return hud
end

function Hud:update(dt)
  
end

function Hud:draw()
  love.graphics.draw(sprites.hud, game.quads.hud.shooterPower, self.shooterPowerPos.x, self.shooterPowerPos.y)
  love.graphics.draw(sprites.hud, game.quads.hud.shooterLevel[game.shooter.level], self.shooterPowerPos.x + 48, self.shooterPowerPos.y + 12)
  love.graphics.print(tostring(game.shooter.power) .. ' / ' .. tostring(game.shooter.levelReqs[game.shooter.level + 1] or game.shooter.levelReqs[5]), fonts.slantNumbers, self.shooterPowerPos.x + 48, self.shooterPowerPos.y)
  
  for i = 0, game.player.lives-1 do
    love.graphics.draw(sprites.hud, game.quads.hud.heart, self.livesPos.x + i * 16, self.livesPos.y)
  end
end

return Hud