
import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/crank"

local gfx <const> = playdate.graphics
local font = gfx.font.new('font/Mini Sans 2X') -- DEMO

local playerSprite = nil

local playerDirection = 2 -- 1 = up -- 2 = right -- 3 = down -- 4 = left

local ticksPerRevolution = 2

local locBufX = 0
local locBufY = 0

function gameSetUp()
	local playerImage = gfx.image.new("Images/playerImage")
	assert ( playerImage )

	playerDirection = 2 -- Start looking to the right (this may change based on the layout of each maze)

	playerSprite = gfx.sprite.new( playerImage )
	playerSprite:moveTo( 200, 120 )
	playerSprite:add()

	local backgroundImage = gfx.image.new( "Images/background" )
	assert ( backgroundImage )

	gfx.setBackgroundColor(0)

	locBufX = playerSprite.x
	locBufY = playerSprite.y

	print(gfx.getColor())
	gfx.setColor(gfx.kColorWhite)
	print(gfx.getColor())

end


function drawPathCircle( x, y, r )
	print(gfx.getColor())
	gfx.fillCircleAtPoint( x, y, r )
end


gameSetUp()


function playdate.update()
	
	
	if playdate.buttonIsPressed( playdate.kButtonUp ) then
        playerDirection = 1
    end
    if playdate.buttonIsPressed( playdate.kButtonRight ) then
        playerDirection = 2
    end
    if playdate.buttonIsPressed( playdate.kButtonDown ) then
        playerDirection = 3
    end
    if playdate.buttonIsPressed( playdate.kButtonLeft ) then
        playerDirection = 4
    end

	

	local crankTicks = playdate.getCrankTicks(ticksPerRevolution)

	-- if crankTicks == 1 then
	-- 	if playerDirection == 1 then
	-- 		playerSprite:moveBy( 0, -8 )
	-- 	end
	-- 	if playerDirection == 2 then
	-- 		playerSprite:moveBy( 8, 0 )
	-- 	end
	-- 	if playerDirection == 3 then
	-- 		playerSprite:moveBy( 0, 8 )
	-- 	end
	-- 	if playerDirection == 4 then
	-- 		playerSprite:moveBy( -8, 0 )
	-- 	end
	-- end
	-- if crankTicks == -1 then
	-- 	if playerDirection == 1 then
	-- 		playerSprite:moveBy( 0, 8 )
	-- 	end
	-- 	if playerDirection == 2 then
	-- 		playerSprite:moveBy( -8, 0 )
	-- 	end
	-- 	if playerDirection == 3 then
	-- 		playerSprite:moveBy( 0, -8 )
	-- 	end
	-- 	if playerDirection == 4 then
	-- 		playerSprite:moveBy( 8, 0 )
	-- 	end
	-- end

	if crankTicks == 1 then
		if playerDirection == 1 then
			locBufY -= 8
		end
		if playerDirection == 2 then
			locBufX += 8
		end
		if playerDirection == 3 then
			locBufY += 8
		end
		if playerDirection == 4 then
			locBufX -= 8
		end

		drawPathCircle( locBufX, locBufY, 4 )

	end

	gfx.sprite.update()

	if playdate.isCrankDocked() then
		playdate.ui.crankIndicator:draw()
	end

    playdate.timer.updateTimers()
	playdate.drawFPS(0,0) -- FPS widget
end
