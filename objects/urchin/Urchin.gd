extends StaticBody2D


func _on_body_entered(body):
	if body == self:
		return
	if body is Fish:
		body.die()
	if body is Player:
		body.die()
