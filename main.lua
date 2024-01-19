local scaleX, scaleY
local hud

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  require 'assets'
  require 'game'
  love.graphics.setBackgroundColor(0.7, 0.2, 1)
  love.graphics.setFont(fonts.dialog)
  
  scaleX = 3
  scaleY = 3
  
  PLAYAREA = {}
  PLAYAREA.ORIGIN = {X = 10, Y = 5}
  PLAYAREA.END = {X = 210, Y = 235}
  
  local Hud = require 'hud'
  hud = Hud.new()
  
  gameInit()
end


function love.update(dt)
  game.player:update(dt)
  game.shooter:update(dt)
  game.enemies.ghost:update(dt, bh)
  game.bh:update(dt)
  hud:update(dt)
end


function love.keypressed(key, scancode, isrepeat)
  if key == 'f4' then
    love.window.setFullscreen(not love.window.getFullscreen())
    
    scaleY = love.graphics.getHeight()/720 * 3
    scaleX = love.graphics.getWidth()/960 * 3
  end
  if key == 'escape' then
    love.event.quit()
  end
end


function love.draw()
  love.graphics.scale(scaleX, scaleY)
  
  love.graphics.stencil(gameStencil, 'replace', 1)
  love.graphics.setStencilTest("greater", 0)
  
  game.shooter:draw()
  game.player:draw()
  game.enemies.ghost:draw()
  game.bh:draw()
  
  love.graphics.rectangle('line', PLAYAREA.ORIGIN.X, PLAYAREA.ORIGIN.Y, PLAYAREA.END.X - PLAYAREA.ORIGIN.X, PLAYAREA.END.Y - PLAYAREA.ORIGIN.Y)
  
  love.graphics.setStencilTest()
  hud:draw(player, shooter)
end


function normalize(x, y)
  local l=(x*x+y*y)^.5 if l==0 then return 0,0,0 else return x/l,y/l,l end
end

-- bullet vector
function bv(angle, startX, startY)
  local radian = math.rad(angle) - math.pi / 2
  if startX and startY then
    radian = radian + math.atan2(startY - game.player.y, startX - game.player.x) + math.pi / 2
  end
  local vx = math.cos(radian)
  local vy = math.sin(radian)
  return {x = vx, y = vy}
end


function distance(x1, y1, x2, y2)
  return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
end


function isCollided(x1, y1, r1, x2, y2, r2)
  return distance(x1, y1, x2, y2) < r1 + r2
end


function gameStencil()
  love.graphics.rectangle('fill', PLAYAREA.ORIGIN.X, PLAYAREA.ORIGIN.Y,
    PLAYAREA.END.X - PLAYAREA.ORIGIN.X, PLAYAREA.END.Y - PLAYAREA.ORIGIN.Y)
end
