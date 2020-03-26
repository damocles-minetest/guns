

guns.register_gun({
  interval = 0.9,
  name = "guns:scout",
  description = "Scout",
  texture = "guns_scout.png",
  ammo = "guns:ammo_9mm",
  ammo_count = 2,
  sound = "guns_beretta",
  damage = 9,
  range = 50,
  on_hit = guns.smoke
})
