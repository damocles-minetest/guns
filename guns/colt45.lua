

guns.register_gun({
  interval = 0.75,
  name = "guns:colt45",
  description = "Colt",
  texture = "guns_colt45.png",
  ammo = "guns:ammo_9mm",
  ammo_count = 6,
  sound = "guns_beretta",
  damage = 5,
  range = 50,
  on_hit = guns.smoke
})
