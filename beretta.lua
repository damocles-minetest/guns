
minetest.register_craftitem("guns:beretta_ammunition", {
	description = "Beretta 9mm ammunition",
	inventory_image = "guns_beretta_ammunition.png",
	stack_max = 25
})

guns.register_gun({
  interval = 0.25,
  name = "guns:beretta",
  description = "Beretta",
  texture = "guns_beretta.png",
  ammo = "guns:beretta_ammunition",
  ammo_count = 25,
  sound = "guns_beretta",
  damage = 2
})
