local anim8 = require 'vendor/anim8'

game = {}

function gameInit()
  game.grids = {}
  game.grids.bulletRound = {
    anim8.newGrid(6, 6, sprites.bullets:getWidth(), sprites.bullets:getHeight()),
    anim8.newGrid(8, 8, sprites.bullets:getWidth(), sprites.bullets:getHeight(), 0, 6),
    anim8.newGrid(10, 10, sprites.bullets:getWidth(), sprites.bullets:getHeight(), 0, 14)
  }
  game.grids.bulletPoint = anim8.newGrid(5, 8, sprites.bullets:getWidth(), sprites.bullets:getHeight(), 0, 24)
  game.grids.player = anim8.newGrid(16, 16, sprites.player.default:getWidth(), sprites.player.default:getHeight())
  
  game.grids.enemies = {}
  game.grids.enemies.ghost = anim8.newGrid(16, 16, sprites.enemies.ghost:getWidth(), sprites.enemies.ghost:getHeight())
  
  game.quads = {}
  game.quads.playerHit = game.grids.player('3-3', 1)[1]
  
  game.quads.hud = {}
  game.quads.hud.heart = love.graphics.newQuad(0, 24, 16, 16, sprites.hud:getWidth(), sprites.hud:getHeight())
  game.quads.hud.shooterPower = love.graphics.newQuad(0, 0, 48, 12, sprites.hud:getWidth(), sprites.hud:getHeight())
  game.quads.hud.shooterLevel = {
    love.graphics.newQuad(0, 12, 6, 12, sprites.hud:getWidth(), sprites.hud:getHeight()),
    love.graphics.newQuad(6, 12, 10, 12, sprites.hud:getWidth(), sprites.hud:getHeight()),
    love.graphics.newQuad(16, 12, 14, 12, sprites.hud:getWidth(), sprites.hud:getHeight()),
    love.graphics.newQuad(30, 12, 14, 12, sprites.hud:getWidth(), sprites.hud:getHeight()),
    love.graphics.newQuad(44, 12, 56, 12, sprites.hud:getWidth(), sprites.hud:getHeight())
  }
  
  game.quads.enemies = {}
  game.quads.enemies.ghost = {}
  game.quads.enemies.ghost.prepare = game.grids.enemies.ghost('1-1', 2)[1]
  game.quads.enemies.ghost.attack = game.grids.enemies.ghost('2-2', 2)[1]
  
  local Player = require 'player'
  game.player = Player.new(100, 100)
  local Shooter = require 'shooter'
  game.shooter = Shooter.new()
  
  game.enemies = {}
  local Ghost = require 'enemies/ghost'
  game.enemies.ghost = Ghost.new(100, 50)
  local BulletHandler = require 'bullets'
  game.bh = BulletHandler.new()
  
end