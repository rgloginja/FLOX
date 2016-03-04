local composer = require( "composer" )
local scene = composer.newScene()

local x

local BackgroundImage

local backgroundMusic
local backgroundMusicChannel

local StartButton

local function loadGame( event )
    
    if (event.phase == "ended") then

        print("Load Game")
        local options = {
            effect = "crossFade",
            time = 1000
        }

        composer.removeScene("gameMain")
        composer.gotoScene( "gameMain", options )
        return true
    end
end

function scene:create( event )
    local sceneGroup = self.view

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

end

function scene:show( event )
    local sceneGroup = self.view

    if event.phase == "did" then
        --composer.removeScene( "gameMain" ) 
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
         --composer.removeScene('menu')
    end

end

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
