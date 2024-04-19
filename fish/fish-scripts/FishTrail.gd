class_name FishTrail
extends Line2D

var live : bool  = true

var fish : Fish
var pixelated = 3
var prev_pos : Vector2

func install(f : Fish, ftg : Gradient):
	fish = f
	gradient = ftg
	set_width(pixelated)

func update(delta) -> void:
	if (live):
		var local = to_local(fish.global_position)
		#var x = snapped(local.x, pixelated)
		#var y = snapped(local.y, pixelated)
		#local = Vector2(x, y)
		
		if get_point_count() == 0: # first time
			add_point(local)
			add_point(local)
		else:
			add_point(local)

func die():
	live = false
