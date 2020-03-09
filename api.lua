
guns.register_gun = function(def)

local ammo_def = minetest.registered_items[def.ammo]

local description = def.description .. " " ..
	minetest.colorize("#ff0000", "Damage: ") .. def.damage .. " " ..
	minetest.colorize("#00ff00", "Range: ") .. def.range .. " " ..
	minetest.colorize("#ff00ff", "Reload time: ") .. def.interval .. "s " ..
	minetest.colorize("#0000ff", "Ammo capacity: ") .. def.ammo_count ..
	" x " .. ammo_def.description

minetest.register_tool(def.name, {
	description = description,
	range = 0,
	inventory_image = def.texture,
	on_secondary_use = function(itemstack, player)
		local wear = 65535 / def.ammo_count
		local is_empty = itemstack:get_wear() >= (65535 - wear)

		if not is_empty then
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

		if not guns.can_shoot(player, def.interval) then
			return itemstack
		end

		local wear = 65535 / def.ammo_count
		local is_empty = itemstack:get_wear() >= (65535 - wear)

		if is_empty then
			minetest.sound_play("guns_empty", {pos=player:get_pos()})
			return
		else
			minetest.sound_play(def.sound, {pos=player:get_pos()})
			itemstack:add_wear(wear)
		end


    local raybegin = vector.add(player:get_pos(),{x=0, y=player:get_properties().eye_height, z=0})
    local rayend = vector.add(raybegin, vector.multiply(player:get_look_dir(), def.range))
    local ray = minetest.raycast(raybegin, rayend, true, false)
    ray:next() -- player
    local pointed_thing = ray:next()

    if not pointed_thing then
      return itemstack
    end

    local dir = player:get_look_dir()

    if pointed_thing.type == "object" then
      local object = pointed_thing.ref
      if object and object.get_luaentity and object:get_luaentity() and
				object:get_luaentity().name == "__builtin:item" then
        object:remove()
				if def.on_hit then
					def.on_hit(object:get_pos(), dir)
				end
      else
	      object:punch(player, 1.0, {
	        full_punch_interval = 1.0,
	        damage_groups= {fleshy = def.damage},
	      })
			end

    elseif pointed_thing.type == "node" then
			if def.on_hit then
				def.on_hit(pointed_thing.above, dir)
			end

    end

		return itemstack
  end
})

end
