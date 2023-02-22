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
	if isStoryMode and not seenCutscene then
		startVideo('Cutscene2Meat');
		seenCutscene = true;
		return Function_Stop;
	end
	return Function_Continue;
end  