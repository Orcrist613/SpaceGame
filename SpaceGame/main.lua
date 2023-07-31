function love.load()

    --love.window.setFullscreen(true, "desktop")
    coreWidth = love.graphics.getWidth()
    coreHeight = love.graphics.getHeight() 
    scale = 1
    shiftDown = 0
    osString = love.system.getOS()
    if osString == "Windows" then
        scale = love.graphics.getWidth()/coreWidth
        shiftDown = (love.graphics.getHeight() - (coreHeight * scale)) / 2 / scale
        love.window.setMode(coreWidth * scale, coreHeight * scale)
    
    end

    
    

    sprites = {}
    sprites.ship = love.graphics.newImage('sprites/ship.png')
    sprites.uzayBackG = love.graphics.newImage('sprites/uzayBackG.png')
    sprites.bullet = love.graphics.newImage('sprites/bullet.png')
    sprites.dusman = love.graphics.newImage('sprites/DusmanGemi.png')
    sprites.engel = love.graphics.newImage('sprites/engel.png')

    ship = {}
    ship.x = love.graphics.getWidth() / 2
    ship.y = love.graphics.getHeight() / 2
    ship.speed = 370
    
    dusman = {}
    dusman.x = love.graphics.getWidth() / 2
    dusman.y = love.graphics.getHeight() / 2
    dusman.speed = 370

    bullets = {}
    bulletsdus = {}

    engel = {}
    engel.x  = love.graphics.getWidth() / 2 
    engel.y  = love.graphics.getHeight() / 2 

    spEng = 800

    myFont = love.graphics.newFont(30)
    

end   
function love.update(dt)

    
        if love.keyboard.isDown("d") and ship.x < love.graphics.getWidth() - 24  then 

         ship.x = ship.x + ship.speed*dt

        end
        if love.keyboard.isDown("a") and ship.x > 24 then 

         ship.x = ship.x - ship.speed*dt

        end

        if love.keyboard.isDown("right") and dusman.x < love.graphics.getWidth() - 24 then 

            dusman.x = dusman.x + dusman.speed*dt
    
        end
        if love.keyboard.isDown("left") and dusman.x > 24 then 
    
            dusman.x = dusman.x - dusman.speed*dt
    
        end
        
        engel.x = engel.x + spEng * dt * scale

        if engel.x / 2 > coreWidth * scale or engel.x /2 < 10 then 

            spEng = spEng * -1

        end

        for i,b in ipairs(bullets) do

            
            b.y = b.y - (b.speed *dt )
       
        end
        
        for i,b in ipairs(bulletsdus) do

            b.y = b.y + (b.speed *dt )
       
        end

        for i=#bullets, 1, -1 do
            local b = bullets[i]
            if b.dead == true then
                table.remove(bullets, i)
            end
        end

        for i=#bulletsdus, 1, -1 do
            local b = bulletsdus[i]
            if b.dead == true then
                table.remove(bulletsdus, i)
            end
        end

        for i=#bullets, 1, -1 do
            local b = bullets[i]
               if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then 
                table.remove(bullets, i) 
               end
           end

        for i=#bulletsdus, 1, -1 do
            local b = bulletsdus[i]
               if b.x < 0 or b.y < 0 or b.x > love.graphics.getWidth() or b.y > love.graphics.getHeight() then 
                table.remove(bulletsdus, i) 
               end
           end

           


end
function love.draw()
love.graphics.scale(scale)

love.graphics.draw(sprites.uzayBackG, 0, 0, 0, scale)
love.graphics.draw(sprites.ship, ship.x - 24 * scale, coreHeight * scale - 75)
love.graphics.draw(sprites.dusman, dusman.x - 24 * scale, 25 * scale)
love.graphics.draw(sprites.engel, engel.x / 2, engel.y)

for i,b in ipairs(bullets) do

    love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5, sprites.bullet:getWidth()/2, sprites.bullet:getHeight()/2)

end

for i,b in ipairs(bulletsdus) do

    love.graphics.draw(sprites.bullet, b.x, b.y, nil, 0.5, 0.5, sprites.bullet:getWidth()/2, sprites.bullet:getHeight()/2)

end

end

function love.keypressed(key)

    if love.keyboard.isDown("space") then
     spawnShipBullet()
    end
    if love.keyboard.isDown(".") then 
        spawnEnemyBullet()
       end
end


function spawnShipBullet()

    local bullet = {}

    bullet.x = ship.x
    bullet.y = ship.y * 2 - 75 
    bullet.speed = 480
    table.insert(bullets, bullet)

end
function spawnEnemyBullet()

    local bullet = {}

    bullet.x = dusman.x
    bullet.y = 70
    bullet.speed = 480
    table.insert(bulletsdus, bullet)

end






