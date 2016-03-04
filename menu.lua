---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = "menu"

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------
local x

local BackgroundImage

local backgroundMusic
local backgroundMusicChannel

local StartButton

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
    local function loadGame( event )
        -- body
        local options = {
            effect = "fade",
            time = 1000
        }

        composer.gotoScene( "mainGame", options )

    end

    backgroundMusic = audio.loadSound( "bg2.ogg" )
    backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=50 } )

    x=display.contentWidth

    BackgroundImage = display.newImage( "bg2.jpg", true )
    BackgroundImage.x = display.contentWidth / 2
    BackgroundImage.y = display.contentHeight / 2
    BackgroundImage.height = display.contentHeight
    BackgroundImage.width = display.contentWidth * 1.5
    sceneGroup:insert(BackgroundImage)

    StartButton = display.newText("Click To Start", display.contentWidth/2,display.contentHeight/2,'blowbrush',32)
    StartButton:setFillColor(0)
    StartButton:addEventListener("touch", loadGame)
    sceneGroup:insert(StartButton)

    function function1(e)
        transition.to(StartButton,{time=800,alpha=1, onComplete=function2})
    end

    function function2(e)
        transition.to(StartButton,{time=800,alpha=0, onComplete=function1})
    end
    transition.to(StartButton,{time=800,alpha=0.2, onComplete = function1})

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
       
    elseif phase == "did" then
       --composer.removeScene("mainGame");
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
        --composer.removeScene("menu")
		
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
