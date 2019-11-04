
minetest.register_craftitem("guns:beretta_ammunition", {
	description = "Beretta 9mm ammunition",
	inventory_image = "guns_beretta_ammunition.png",
	stack_max = 25
})

minetest.register_tool("guns:beretta", {
	description = "Beretta",
	range = 0,
	inventory_image = "guns_beretta.png",
	on_secondary_use = function(itemstack, player)
		if itemstack:get_wear() < 65535 then
			-- still loaded
			return
		end

		local player_inv = player:get_inventory()
		local ammo_stack = ItemStack("guns:beretta_ammunition 25")

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

		local wear = 65535 / 25
		if itemstack:get_wear() >= (65535 - wear) then
			minetest.sound_play("guns_empty", {pos=player:get_pos()})
			return
		else
			minetest.sound_play("guns_beretta", {pos=player:get_pos()})
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

        minetest.add_particle({
          pos = object:get_pos(),
          velocity = {x=dir.x * 3, y=dir.y * 3, z=dir.z * 3} ,
          acceleration = {x=dir.x * -4, y=2, z=dir.z * -4},
          expirationtime = 0.7,
          size = 5,
          collisiondetection = false,
          vertical = false,
          texture = "tnt_smoke.png",
          glow = 5,
        })
      else
	      object:punch(player, 0.2,{
	        full_punch_interval = 1.0,
	        damage_groups= {fleshy = 5},
	      })
			end

    elseif pointed_thing.type == "node" then
      minetest.add_particle({
        pos = pointed_thing.above,
        velocity = {x=dir.x * 3, y=dir.y * 3, z=dir.z * 3} ,
        acceleration = {x=dir.x * -4, y=2, z=dir.z * -4},
        expirationtime = 0.7,
        size = 5,
        collisiondetection = false,
        vertical = false,
        texture = "tnt_smoke.png",
        glow = 5,
      })
    end

		return itemstack
  end
})
