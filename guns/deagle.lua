

guns.register_gun({
  interval = 0.2,
  name = "guns:deagle",
  description = "Desert eagle",
  texture = "guns_deagle.png",
  ammo = "guns:ammo_9mm",
  ammo_count = 30,
  sound = "guns_beretta",
  damage = 5,
  range = 50,
  on_hit = guns.smoke
})
