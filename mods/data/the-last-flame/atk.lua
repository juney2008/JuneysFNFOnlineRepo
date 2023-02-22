local atkcounter = 0;
function goodNoteHit(id, direction, noteType, isSustainNote)
	if not isSustainNote then
		if atkcounter ~= 100 then
         atkcounter = atkcounter + 1 
	    end
	setProperty('boobs.scale.y',atkcounter * 2)
	setProperty('boobs.origin.y', 1)
	end
	
	--makeLuaText('atkText', 'atk: ' .. atkcounter .. '%' , 300,1050,500)
end
function onCreatePost()
	makeLuaText('atkText', 'atk: ' .. atkcounter .. '%' , 300,1050,500)
    addLuaText('atkText')
    setTextSize('atkText', 40);
    setObjectCamera('atkText', 'hud')
	makeLuaSprite('boobs', '', 1150, 500)
	makeGraphic('boobs', 100, 1, '000000')
	addLuaSprite('boobs',false)
	setObjectCamera('boobs','hud')
	setObjectCamera('atkText','hud')
	setProperty('boobs.alpha',0.8)
	if atkcounter == 100 then 
		setProperty('boobs.alpha',1)
	end
end

function onUpdate(elapsed)
	-- start of "update", some variables weren't updated yet
    setTextString('atkText',atkcounter .. '%' )
	if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') then
		if atkcounter == 100 then
			atkcounter = atkcounter - atkcounter 
			setProperty('boobs.scale.y',1)
			characterPlayAnim('boyfriend', 'pre-attack', true)
			setProperty('boyfriend.specialAnim',true)
			runTimer('lmao',0.1)
		end
	end
end
function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'lmao' then 
		characterPlayAnim('boyfriend', 'attack', true)
		setProperty('boyfriend.specialAnim',true)
		setProperty('health',getProperty('health') + 0.5)
	end
end
