-- playername -> time
local last_shoot_time = {}

minetest.register_on_leaveplayer(function(player)
	last_shoot_time[player:get_player_name()] = nil
end)

guns.can_shoot = function(player, interval)
	local name = player:get_player_name()
	local now = os.clock()
	local last_shot = last_shoot_time[name]

	if not last_shot then
		last_shoot_time[name] = now
		return true

	end

	if (now - last_shot) < interval then
		return false

	else
		last_shoot_time[name] = now
		return true

	end
end
