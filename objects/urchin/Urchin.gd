extends Area2D

func _on_body_entered(body):
	if body == self:
		return
	if body is Fish or body is Player:
		body.die()
