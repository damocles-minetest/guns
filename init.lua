
minetest.register_tool("guns:beretta", {
		description = "Beretta",
	wield_scale = {x=1.1,y=1.1,z=1.05},
	range = 0,
	inventory_image = "guns_beretta.png",
	on_use = function(itemstack, player, pointed_thing)
    minetest.sound_play("guns_beretta", {pos=player:get_pos()})

    local raybegin = vector.add(player:get_pos(),{x=0, y=player:get_properties().eye_height, z=0})
    local rayend = vector.add(raybegin, vector.multiply(player:get_look_dir(), 50))
    local ray = minetest.raycast(raybegin, rayend, true, false)
    ray:next() -- player
    pointed_thing = ray:next()

    -- XXX
    minetest.chat_send_player(player:get_player_name(), dump(pointed_thing))

    if not pointed_thing then
      return
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
        return
      end

      object:punch(player, 0.2,{
        full_punch_interval = 1.0,
        damage_groups= {fleshy = 5},
      })

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
  end
})
