

guns.register_gun({
  interval = 0.25,
  name = "guns:beretta",
  description = "Beretta",
  texture = "guns_beretta.png",
  ammo = "guns:ammo_9mm",
  ammo_count = 25,
  sound = "guns_beretta",
  damage = 2,
  range = 50,
  on_hit = guns.smoke
})
