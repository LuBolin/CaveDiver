class_name FishTrail
extends Line2D

func update(delta) -> void:
	var local = to_local(get_parent().global_position)
	if get_point_count() == 0: # first time
		add_point(local)
		add_point(local)
	else:
		add_point(local)
