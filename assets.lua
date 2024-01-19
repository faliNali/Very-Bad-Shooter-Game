
sprites = {}

sprites.player = {}
sprites.player.default = love.graphics.newImage('images/bennie.png')
sprites.player.bullets = love.graphics.newImage('images/player_bullets.png')
sprites.enemies = {}
sprites.enemies.ghost = love.graphics.newImage('images/ghost.png')
sprites.bullets = love.graphics.newImage('images/bullets.png')
sprites.hud = love.graphics.newImage('images/hud.png')

sounds = {}

sounds.player = {}
sounds.player.shoot = love.audio.newSource('sounds/player_shoot.ogg', 'static')
sounds.player.shoot:setVolume(0.15)


fonts = {}

fonts.dialog = love.graphics.newImageFont('images/dialog_font.png', ' ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,!?-+/():;%&`\'*#=[]"')
fonts.slantNumbers = love.graphics.newImageFont('images/hud_font.png', ' 0123456789/')