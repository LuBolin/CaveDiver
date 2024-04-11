class_name FishTrail
extends Line2D

var live : bool  = true

func update(delta) -> void:
	if (live):
		var local = to_local(get_parent().global_position)
		if get_point_count() == 0: # first time
			add_point(local)
			add_point(local)
		else:
			add_point(local)

func die():
	live = false
