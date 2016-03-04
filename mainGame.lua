---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = "mainGame"

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene()

---------------------------------------------------------------------------------

local physics = require("physics")
physics.start()
physics.setGravity( 0, 15 )

local x


local BackgroundImage

local gameTimer

local myCircle

local player

local Score = 0

function scene:create( event )
    local sceneGroup = self.view

    x=display.contentWidth

    BackgroundImage = display.newImage( "bg2.jpg", true )
    BackgroundImage.x = display.contentWidth / 2
    BackgroundImage.y = display.contentHeight / 2
    BackgroundImage.height = display.contentHeight
    BackgroundImage.width = display.contentWidth * 1.5
    sceneGroup:insert(BackgroundImage)

    ScoreText = display.newText("SCORE: "..Score, 20, 20,'blowbrush',24)
    ScoreText:setFillColor(0)
    sceneGroup:insert(ScoreText)

    myCircle = display.newCircle( display.contentWidth / 2, display.contentHeight + 280, display.contentWidth / 1.1 )
    myCircle:setFillColor(0)
    physics.addBody( myCircle, "static", { friction=0, density=1, bounce=0 } )
    sceneGroup:insert(myCircle)

    player = display.newRect(display.contentWidth/2,display.contentHeight/2 - 10,20,20)
    player:setFillColor(0)
    physics.addBody(player, "dynamic", {friction=1, density=1, bounce=0 })
    player.isFixedRotation = true
    sceneGroup:insert(player)

    local function movePlayer( event )

        if(event.phase == "began") then
           
           player.rotation = player.rotation + 180
           transition.to(player,{rotation=-180})
           
           player:setLinearVelocity(0, -230)
          
        else
            
        end

    end

    local function checkPlayer( event )
        -- body
        if (player.x ~= display.contentWidth/2) then

            Runtime:removeEventListener( "touch", movePlayer)
            timer.cancel(gameTimer)
            --composer.removeScene("mainGame")
            local options = {
                effect = "fade",
                time = 1000
            }   

            composer.gotoScene( "menu", options )
            --composer.gotoScene( "menu" )
            
        end
    end

    local function listener( event )
        print( "listener called" )
        local number = math.random(200, display.contentHeight-100)

        local rect = display.newRect(-50,display.contentHeight - number/2,90,number)
        rect:setFillColor(0)
        physics.addBody( rect, "static", { friction=0, density=0.9, bounce=0 } )
        --transition.to( rect, { time=5000, x=(x+100), height=(math.random(display.contentHeight * 2))} )
        sceneGroup:insert(rect)
        local transOpt=math.random(2)

        if(transOpt == 1) then
            transition.to( rect, { time=5000, x=(x+100), y=rect.y+50} )
        else
            transition.to( rect, { time=5000, x=(x+100), y=rect.y-50} )
        end

        player:setLinearVelocity(0, 100)
      
    end


    gameTimer = timer.performWithDelay( 1000, listener, 0 )  --fire every 10 seconds

    Runtime:addEventListener( "touch", movePlayer)
    Runtime:addEventListener( "enterFrame", checkPlayer)

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        
    elseif phase == "did" then
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
   --Runtime:removeEventListener( "touch", movePlayer)
    -- --display:remove(player)
    timer.cancel(gameTimer)
    --composer.removeScene("mainGame");
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
