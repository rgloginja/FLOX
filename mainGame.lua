--Attack of the killer cubes

local composer = require( "composer" )
local scene = composer.newScene()

local physics = require( "physics" )

local x
local BackgroundImage
local gameTimer
local myCircle
local player
local Score = 0

function scene:create( event )
    
    local sceneGroup = self.view

    --composer.removeScene( "menu" )

    physics.start()
    local function handleLoss( event )

        --composer.removeScene("menu")
        composer.gotoScene("menu", { time= 500, effect = "crossFade" })

        return true

    end

    local function movePlayer( event )

        if(event.phase == "began") then
           
        else
           
           player.rotation = player.rotation + 180
           transition.to(player,{rotation=-180})
           
           player:setLinearVelocity(0, -230)

        end

    end

    local function checkPlayer( event )
        -- body
        if (player.x ~= display.contentWidth/2) then

            handleLoss()
            
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


    gameTimer = timer.performWithDelay( 1000, listener, 0 )  --fire every 10 seconds

    Runtime:addEventListener( "touch", movePlayer)
    Runtime:addEventListener( "enterFrame", checkPlayer)

end

--
-- This gets called twice, once before the scene is moved on screen and again once
-- afterwards as a result of calling composer.gotoScene()
--
function scene:show( event )
    --
    -- Make a local reference to the scene's view for scene:show()
    --
    local sceneGroup = self.view

    
    if event.phase == "did" then
        
        physics.start()
        
        physics.setGravity( 0, 15 )
       
    else -- event.phase == "will"
       
    end
end

--

function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
        -- The "will" phase happens before the scene is transitioned off screen. Stop
        -- anything you started elsewhere that could still be moving or triggering such as:
        -- Remove enterFrame listeners here
        -- stop timers, phsics, any audio playing
        --
        --physics.stop()        
        timer.cancel( gameTimer )
    end

end

--
-- When you call composer.removeScene() from another module, composer will go through and
-- remove anything created with display.* and inserted into the scene's view group for you. In
-- many cases that's sufficent to remove your scene. 
--
-- But there may be somethings you loaded, like audio in scene:create() that won't be disposed for
-- you. This is where you dispose of those things.
-- In most cases there won't be much to do here.
function scene:destroy( event )
    local sceneGroup = self.view
    
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
