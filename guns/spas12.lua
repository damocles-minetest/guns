

guns.register_gun({
  interval = 1.5,
  name = "guns:scout",
  description = "Scout",
  texture = "guns_scout.png",
  ammo = "guns:shell",
  ammo_count = 5,
  sound = "guns_shotgun",
  damage = 8,
  range = 50,
  on_hit = guns.smoke
})
