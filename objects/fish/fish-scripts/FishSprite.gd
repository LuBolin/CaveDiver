class_name FishSprite
extends AnimatedSprite2D

var died = false

func update(angle) -> void:
	if died:
		return
	if (angle > PI / 2 || angle < -PI / 2):
		scale = Vector2(1, -1)
		angle -= PI/4.0
	else:
		scale = Vector2(1, 1)
		angle += PI/4.0
	rotation = angle

func die():
	died = true
	rotation = -3*PI/4
	self.set_modulate(Color.BLACK)
