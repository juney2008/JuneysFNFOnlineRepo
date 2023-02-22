function onCreate()
    --you can copy the parts below as much as you want
	makeAnimatedLuaSprite('wakubackground-chase', 'wakubackground-chase', 2000, 400)
	addAnimationByPrefix('wakubackground-chase','wakubackground-chase','scroll',18, true)
	setProperty('wakubackground-chase.antialiasing', false)
	scaleObject('wakubackground-chase', 10, 10)
end

function onUpdate(elapsed)
	if curStep == 400 then
	    removeLuaSprite('wakubackground', false); --you can copy this as much as you want
	    removeLuaSprite('car', false);
		addLuaSprite('wakubackground-chase', false); --Or true

	    for i=0,4,1 do
		    setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets');
		    setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_assets');
	    end
	end

	if curStep == 400 then --This one MUST be at least 16 or 32 steps earlier (depends of the version of Psych Engine)
        for i = 0, getProperty('unspawnNotes.length')-1 do
		    setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets');
            end
	end
    end