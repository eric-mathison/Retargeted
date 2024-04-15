local function feigning()
	local i, buff = 1, nil
	repeat
		buff = UnitBuff('target', i)
		if buff == [[Interface\Icons\Ability_Rogue_FeignDeath]] then
			return true
		end
		i = i + 1
	until not buff
	return UnitCanAttack('player', 'target')
end

local function ClassCheck()
    if (UnitClass'target' == 'Hunter' or UnitClass'target' == 'Rogue') then
        return true
    else 
        return false
    end
end

local unit, dead, lost, player, classcheck

CreateFrame'Frame':SetScript('OnUpdate', function()
	local target = UnitName'target'
	if (target) then
		unit, dead, lost, player, classcheck = target, UnitIsDead'target', false, UnitIsPlayer'target', ClassCheck()
	elseif (unit and player and classcheck) then
		TargetByName(unit, true)
		if UnitExists'target' then
			if not (lost or (not dead and UnitIsDead'target' and feigning())) then
				ClearTarget()
				unit, lost = nil, false
			end
		else
			lost = true
		end 
	end
end)