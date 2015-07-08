---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local composer = require( "composer" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------
    gameTimers = {}
    gameTimers.frame = 0
    gameTimers.totalTime = 0
    gameTimers.spawnTime = 0
    gameTimers.gameStarted = false
    playerFrog = {}
    startPad = {}
    pad = {}

    spawned= false 
local nextSceneButton

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc

    gameTimers = {}
    gameTimers.frame = 0
    gameTimers.totalTime = 0
    gameTimers.spawnTime = 0
    playerFrog = {}
    startPad = {}
    terrainObjects = {}


end


local onUpdate = function( event )

-- print ("something")

if gameTimers.gameStarted then

    if startPad then 

    startPad.x = startPad.x -1 

  --  if startPad.x > -20 then
   --     startPad:removeSelf( )
  --      startPad= nil
  --  end
    -- print ("There is a start pad!!!!")
    end

    if playerFrog.isOnSomething then

    playerFrog.x = playerFrog.x - 1

    end

    gameTimers.frame = gameTimers.frame + 1
    gameTimers.spawnTime = gameTimers.spawnTime +1
    if pad then 
       --  print ("There is a pad!")
    end

    if gameTimers.frame == 31 then
        gameTimers.frame= 0
      print ("frame 30")
    end

    -- padsmall.x = 320
      --  padsmall.y = 350

    if gameTimers.spawnTime == 50 and spawned== false then
        print ("makePad")
       --numberOfPads = numberOfPads +1 
      gameTimers.spawnTime =0 
      
      spawnPad =  padsmall -- display.newImage("images/pad1.png")
      spawnPad.x = 330
      spawnPad.y = 340

      spawned= true

    end

    if spawned == true then
        print ("but hey, spawned =- true!")
      -- spawnPad.x = spawnPad.x -1
      --spawnPad.y = spawnPad.y +1
      spawnPad.x = spawnPad.x -1
      if spawnPad.x < -20 then

        spawnPad:removeSelf( )
        spawnPad = nil
      end

    end

end

end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen

--        local goToScene3Btn = self:getObjectByName( "GoToScene3Btn" )''

    local touchObject

    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc


        Runtime:addEventListener( "enterFrame", onUpdate )

        playerFrog = self:getObjectByName( "PlayerFrog" )
        startPad = self:getObjectByName( "StartPad" )
        padsmall = self:getObjectByName("Padsmall")
        startPad.myName = "startpad"
        padsmall.myName = "padsmall"

        local function onLocalCollision( self, event )

            if ( event.phase == "began" ) then
                print ("Hit started")
                gameTimers.gameStarted = true
                playerFrog.isOnSomething = true
                                                   -- print( self.myName .. ": collision began with " .. event.other.myName )
            end


            return
           
        end

        playerFrog.collision = onLocalCollision
        playerFrog:addEventListener( "collision", playerFrog )

        padsmall.collision = onLocalCollision
        padsmall:addEventListener( "collision", padsmall )

      --  padsmall.x = 320
      --  padsmall.y = 350

        if nextSceneButton then
        	-- touch listener for the button
        	function nextSceneButton:touch ( event )
        		local phase = event.phase
        		if "ended" == phase then
        			composer.gotoScene( "scene3", { effect = "fade", time = 300 } )
        		end
        	end
        	-- add the touch event listener to the button
        	nextSceneButton:addEventListener( "touch", nextSceneButton )
        end
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
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
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
