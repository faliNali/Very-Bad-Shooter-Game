local Shooter = {}
Shooter.__index = Shooter

function Shooter.new()
  local shooter = {}
  setmetatable(shooter, Shooter)
  
  shooter.bullets = {}
  shooter.bulletSpeed = 300
  shooter.bulletSpeeds = {}
  shooter.bulletRadius = 4
  shooter.maxTimer = 0.1
  shooter.timer = 0
  shooter.power = 100
  shooter.levels = {
    {bv(0)},
    {bv(-1.5), bv(1.5)},
    {bv(-4), bv(0), bv(4)},
    {bv(-9), bv(-3), bv(3), bv(9)},
    {bv(-10), bv(-5), bv(0), bv(5), bv(10)}
  }
  shooter.level = 1
  shooter.bulletPattern = shooter.levels[shooter.level]
  shooter.levelReqs = {0, 20, 40, 80, 160}
  shooter.radius = 5
  return shooter
end


function Shooter:update(dt)
  if self.timer > 0 then
    self.timer = self.timer - dt
  end
  
  self.bulletPattern = self.levels[self.level]
  
  if love.keyboard.isDown('z') and self.timer <= 0 then
    for i, v in ipairs(self.bulletPattern) do
      table.insert(self.bullets, {x = game.player.x, y = game.player.y, velocity = v})
    end
    self.timer = self.timer + self.maxTimer
    love.audio.play(sounds.player.shoot)
  end
  
  for i, v in ipairs(self.bullets) do
    v.x = v.x + v.velocity.x * self.bulletSpeed * dt
    v.y = v.y + v.velocity.y * self.bulletSpeed * dt
    if v.x < PLAYAREA.ORIGIN.X-5 or v.x > PLAYAREA.END.X+5 or v.y < PLAYAREA.ORIGIN.Y-5 or v.y > PLAYAREA.END.Y+5 then
      table.remove(self.bullets, i)
    end
    for ei, en in pairs(game.enemies) do
      if distance(en.x, en.y, v.x, v.y) <= en.radius + game.shooter.radius then
        en.health = en.health - 1
        table.remove(self.bullets, i)
      end
    end
  end
  
  for i = #self.levelReqs, 1, -1 do
    if self.power >= self.levelReqs[i] then
      self.level = i
      if i == 5 then
        self.power = self.levelReqs[i]
      end
      break
    end
  end
end


function Shooter:draw()
  love.graphics.setColor(1, 1, 1, 0.8)
  for i, v in ipairs(self.bullets) do
    love.graphics.draw(sprites.player.bullets, v.x, v.y, 0, 1, 1, 5, 5)
  end
  love.graphics.setColor(1, 1, 1, 1)
end


return Shooter