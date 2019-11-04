
guns.smoke = function(pos, dir)
  minetest.add_particle({
    pos = pos,
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
