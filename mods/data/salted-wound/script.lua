local seenCutsceneend = false
local seenVideo = false
local actuallend = false
local shakethatbar = 0
local shakethatbarx = 0
local drainingHealth = false
local deathstate = 0

function onStartCountdown()
	if botPlay then
		makeLuaSprite('shameBG', nil, -0, -0)
		luaSpriteMakeGraphic('shameBG', screenWidth, screenHeight, 'a2a2a2')
		setObjectCamera('shameBG', 'other')	
		addLuaSprite('shameBG', true)
	
		makeLuaSprite('dissapointed', 'fuckingcubes/Why', -0, -0)
		setObjectCamera('dissapointed', 'other')	
		addLuaSprite('dissapointed', true)
		playSound('dissaproval')
		screenCenter('dissapointed', 'xy')
		return Function_Stop
	end
	if isStoryMode and not seenVideo and not seenCutscene then
		startVideo('Cutscene3Meat')
		setProperty('cutsceneTransition.alpha', 1)
		seenVideo = true
		return Function_Stop
	end
	if isStoryMode and seenVideo and not seenCutscene then
		doTweenAlpha('ohBoyHereWeGo', 'cutsceneTransition', 0, 2)
	return Function_Continue
	end
end
function onCreatePost()

		shakethatbar = getProperty('healthBar.y')
		shakethatbarx = getProperty('healthBar.x')
		
end

function onCreate()

	makeLuaSprite('cutsceneTransition', nil, -0, -0)
		luaSpriteMakeGraphic('cutsceneTransition', screenWidth, screenHeight, 'FFFFFF')
	
	makeAnimatedLuaSprite('lillerbitch', 'funnyhpbar/Liller_Slugger', getProperty('healthBar.x') + 300 , getProperty('healthBar.y') - 3000)
		luaSpriteAddAnimationByPrefix('lillerbitch', 'ohnoimfalling', 'Fell off', 24, true)
		luaSpriteAddAnimationByPrefix('lillerbitch', 'loop', 'Liller Slugger', 24, true)
		
	makeAnimatedLuaSprite('goinghealthdown', 'funnyhpbar/goingdown', getProperty('healthBar.x'), getProperty('healthBar.y'))
		luaSpriteAddAnimationByPrefix('goinghealthdown', 'loop', 'movingbar', 60, true)
		
	makeAnimatedLuaSprite('hahadumbass', 'funnyhpbar/Death', defaultBoyfriendX, defaultBoyfriendY + 350)
		luaSpriteAddAnimationByPrefix('hahadumbass', 'notyet', 'HoldOn', 24, false)
		luaSpriteAddAnimationByPrefix('hahadumbass', 'whatabitch', 'GameOver', 24, false)
		
	setObjectCamera('goinghealthdown', 'camHUD')
	setObjectCamera('lillerbitch', 'camHUD')
	setObjectCamera('cutsceneTransition', 'other')	
	
	setProperty('goinghealthdown.alpha', 0)
	setProperty('hahadumbass.alpha', 0)
	setProperty('cutsceneTransition.alpha', 0)
	
	setObjectOrder('goinghealthdown', getObjectOrder('healthBar') + 1)
	
	scaleLuaSprite('lillerbitch', 0.8, 0.8)
	scaleLuaSprite('goinghealthdown', 1.1, 1.1)
	
	addLuaSprite('lillerbitch', true)
	addLuaSprite('goinghealthdown', false)
	addLuaSprite('hahadumbass', true)
	addLuaSprite('cutsceneTransition', true)
end
function onEndSong()
	if isStoryMode and not seenCutsceneend then
		setProperty('inCutscene', true)
		runTimer('transition', 0.1)
		seenCutsceneend = true
		return Function_Stop
		
	end		
	if isStoryMode and not actuallend then
		return Function_Stop
		
		end
	return Function_Continue
	
end

function onUpdatePost()
	if drainingHealth then
		if getProperty('health') < 1 then
			setProperty('health', 0)
		end
		setProperty('healthBar.y', math.random(shakethatbar - 2, shakethatbar + 2))
		setProperty('healthBar.x', math.random(shakethatbarx - 2, shakethatbarx + 2))
		setProperty('healthBarBG.x', getProperty('healthBar.x')-5)
		setProperty('healthBarBG.y', getProperty('healthBar.y')-5)
		setProperty('goinghealthdown.x', getProperty('healthBar.x'))
		setProperty('goinghealthdown.y', getProperty('healthBar.y'))
		setProperty('lillerbitch.y', math.random(shakethatbar - 2 - 230, shakethatbar + 2 - 230))
		setProperty('lillerbitch.x', math.random(shakethatbarx - 2 + 300, shakethatbarx + 2 + 300))

	end
end
function onTweenCompleted(tag)
	if tag == 'shitgotreal' then
		drainingHealth = true
		setPropertyFromClass('GameOverSubstate', 'characterName', 'whatadumbass')
		setPropertyFromClass('GameOverSubstate', 'deathSoundName', 'getfucked')
	end
	if tag == 'lillermf' then
		objectPlayAnimation('lillerbitch', 'loop', true)
		setProperty('lillerbitch.offset.y', -90)
		setProperty('goinghealthdown.angle', 5)
		setProperty('healthBarBG.angle', 5)
		setProperty('healthBar.angle', 5)
		setProperty('lillerbitch.y', getProperty('healthBar.y')-270)
		doTweenY('end', 'lillerbitch', getProperty('healthBar.y') - 230, 0.3, 'bounceOut')
		doTweenAngle('bouncy', 'healthBar', 0, 0.3, 'bounceOut')
		doTweenAngle('bouncybg', 'healthBarBG', 0, 0.3, 'bounceOut')
		doTweenAngle('bouncyover', 'goinghealthdown', 0, 0.3, 'bounceOut')
		doTweenAlpha('shitgotreal', 'goinghealthdown', 0.6, 1, 'bounceOut')
	end
end
function onBeatHit()
	if curBeat == 126 then
		doTweenY('lillermf', 'lillerbitch', getProperty('healthBar.y') - 230, 1/(bpm / 60))
	end
	if drainingHealth then
		setProperty('health', getProperty('health') - 0.027)
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'transition' then
		runTimer('funny', 27.3)
		startVideo('CutsceneEndMeat')
	
	end
	
	if tag == 'funny' then
	actuallend = true
		endSong()
		
	end
	
end