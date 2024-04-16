extends Area2D


# player main collider != player head collider
# main collider is placed above
# so it's shape_index is 0


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if not (body and is_instance_valid(body)):
		return
	if body is Player and body_shape_index == 0:
		return
	if body.get('in_water') is bool:
		body.in_water = false

func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if not (body and is_instance_valid(body)):
		return
	if body is Player and body_shape_index == 0:
		return
	if body.get('in_water') is bool:
		body.in_water = true
