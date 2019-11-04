
--[[
guns.register_gun({
  interval = 0.25,
  name = "guns:beretta",
  description = "Beretta",
  texture = "guns_beretta.png",
  ammo = "guns:beretta_ammunition",
  sound = "guns_beretta",
  ammo_count = 25
})

--]]
guns.register_gun = function(def)

-- playername -> time
local last_shoot_time = {}

minetest.register_on_leaveplayer(function(player)
	last_shoot_time[player:get_player_name()] = nil
end)

local function can_shoot(player)
	local name = player:get_player_name()
	local now = os.clock()
	local last_shot = last_shoot_time[name]

	if not last_shot then
		last_shoot_time[name] = now
		return true

	end

	if (now - last_shot) < def.interval then
		return false

	else
		last_shoot_time[name] = now
		return true

	end
end

minetest.register_tool(def.name, {
	description = def.description or "",
	range = 0,
	inventory_image = def.texture,
	on_secondary_use = function(itemstack, player)
		if itemstack:get_wear() < 65535 then
			-- still loaded
			return
		end

		local player_inv = player:get_inventory()
		local ammo_stack = ItemStack(def.ammo .. " " .. def.ammo_count)

		if player_inv:contains_item("main", ammo_stack) then
			-- reload
			player_inv:remove_item("main", ammo_stack)
			itemstack:set_wear(0)
			minetest.sound_play("guns_reload", {pos=player:get_pos()})
		else
			-- no ammo
			minetest.sound_play("guns_empty", {pos=player:get_pos()})
		end

		return itemstack
	end,

	on_use = function(itemstack, player)

		if not can_shoot(player) then
			return itemstack
		end

		local wear = 65535 / def.ammo_count
		if itemstack:get_wear() >= (65535 - wear) then
			minetest.sound_play("guns_empty", {pos=player:get_pos()})
			return
		else
			minetest.sound_play(def.sound, {pos=player:get_pos()})
			itemstack:add_wear(wear)
		end


    local raybegin = vector.add(player:get_pos(),{x=0, y=player:get_properties().eye_height, z=0})
    local rayend = vector.add(raybegin, vector.multiply(player:get_look_dir(), 50))
    local ray = minetest.raycast(raybegin, rayend, true, false)
    ray:next() -- player
    local pointed_thing = ray:next()

    if not pointed_thing then
      return itemstack
    end

    local dir = player:get_look_dir()

    if pointed_thing.type == "object" then
      local object = pointed_thing.ref
      if object.get_luaentity and object:get_luaentity().name == "__builtin:item" then
        object:remove()
        guns.smoke(object:get_pos(), dir)
      else
	      object:punch(player, 0.2, {
	        full_punch_interval = 1.0,
	        damage_groups= {fleshy = def.damage},
	      })
			end

    elseif pointed_thing.type == "node" then
      guns.smoke(pointed_thing.above, dir)

    end

		return itemstack
  end
})

end
