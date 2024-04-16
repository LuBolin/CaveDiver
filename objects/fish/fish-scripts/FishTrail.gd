class_name FishTrail
extends Line2D

var live : bool  = true

var fish : Fish

func install(f : Fish):
	fish = f
	

func update(delta) -> void:
	if (live):
		var local = to_local(fish.global_position)
		if get_point_count() == 0: # first time
			add_point(local)
			add_point(local)
		else:
			add_point(local)

func die():
	live = false
